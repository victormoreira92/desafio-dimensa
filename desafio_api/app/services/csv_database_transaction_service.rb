require 'csv'

class CsvDatabaseTransactionService
  attr_accessor :content_file, :errors, :message

  def initialize(content_file)
    @content_file = content_file
    @errors = []
    @message = { contents: 0 }
  end

  def process
    CSV.parse(@content_file.file_data.download, headers: true) do |row|
      criar_contents(row) if !row['title'].blank?
      associar_content_genres_casts_countries(row)
    end
    { errors: @errors, messages: @message }
  end

  private

  def log_error(message, exception)
    @errors << "#{message}: #{exception.message}"
  end

  def parse_duration(duration)
    type_duration = duration.split(' ')[1].downcase.to_sym
    type_duration == :min ? :minutes : type_duration
  end

  def parse_rating(rating)
    rating = rating.downcase.gsub('-', '').to_sym
    rating == :r ? :rated : rating
  end

  def criar_contents(row)
    type_duration = parse_duration(row['duration'])
    rating = parse_rating(row['rating'])
    type_content = row['type'].downcase.gsub(' ', '_').to_sym
    director_name = row['director'].split(', ').map(&:strip) unless row['director'].blank?
    created_count = 0

    begin
      Content.transaction do
        unless Content.find_by(show_id: row['show_id'])
          Content.create!(
            title: row['title'],
            show_id: row['show_id'],
            type_content: type_content,
            description: row['description'],
            year: row['release_year'].to_i,
            rating: rating,
            duration: row['duration'].split(', ')[0],
            published_at: DateTime.parse(row['date_added']),
            type_duration: type_duration,
            content_file: @content_file,
            director: Cast.find_or_create_by(cast_name: director_name)
          )
          @message[:contents] += 1
        end
      end
    rescue StandardError => e
      log_error("Erro ao criar: #{row['show_id']}", e)
    end
  end

  def build_modelos(row)
    modelos = {}
    modelos[:genre] = row['listed_in'].split(', ').map(&:strip) unless row['listed_in'].blank?
    modelos[:cast] = row['cast'].split(', ').map(&:strip) unless row['cast'].blank?
    modelos[:country] = row['country'].split(', ').map(&:strip) unless row['country'].blank?
    modelos
  end

  def associar_content_genres_casts_countries(row)
    content_criado = Content.find_by(show_id: row['show_id'])
    modelos_associados = build_modelos(row)

    modelos_associados.each_key do |nome_modelo|
      modelos_associados[nome_modelo].each do |dado_atributo|
        atributo = "#{nome_modelo}_name"
        model = nome_modelo.to_s.titlecase.constantize.find_or_create_by(atributo.to_sym => dado_atributo)
        content_criado.send(nome_modelo.to_s.pluralize) << model unless content_criado.send(nome_modelo.to_s.pluralize).include?(model)
      end
    end
  end
end
