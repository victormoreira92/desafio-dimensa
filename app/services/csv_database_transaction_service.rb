require 'csv'

class CsvDatabaseTransactionService
  attr_accessor :content_file, :errors, :message

  COLUNAS_ESPERADAS = %w[show_id type title director	cast
                         country	date_added	release_year rating	duration	listed_in	description].freeze

  def initialize(content_file_id)
    @content_file = ContentFile.find(content_file_id)
    @errors = []
    @message = { contents: nil }
  end

  def process
    line_count = 0
    CSV.parse(@content_file.file_data.download, headers: true) do |row|
      p line_count += 1
      criar_contents(row) if !row['title'].blank?
      associar_content_genres_casts_countries(row)

      # criar_genres(row) if !row['listed_in'].blank?
      # criar_casts(row) if !row['cast'].blank?
      # criar_countries(row) if !row['country'].blank?
    end
    @message
  end

  private

  def criar_contents(row)
    type_duration = row['duration'].split(' ')[1].downcase.to_sym
    type_duration = :minutes if type_duration == :min

    type_content = row['type'].downcase.gsub(' ', '_').to_sym
    created_count = 0


    Content.transaction do
      unless Content.find_by(show_id: row['show_id'])
        Content.create!(
          title: row['title'],
          show_id: row['show_id'],
          type_content: type_content,
          description: row['description'],
          year: row['release_year'].to_i,
          duration: row['duration'].split(', ')[0],
          published_at: DateTime.parse(row['date_added']),
          type_duration: type_duration,
          content_file: @content_file
        )
        created_count += 1
      end
      @message[:contents] += created_count
    end
  end

  def associar_content_genres_casts_countries(row)
    filme = Content.find_by(show_id: row['show_id'])
    modelos = {}

    modelos[:genre] = row['listed_in'].split(', ').map(&:strip) unless row['listed_in'].blank?
    modelos[:cast] = row['cast'].split(', ').map(&:strip) unless row['cast'].blank?
    modelos[:country] = row['country'].split(', ').map(&:strip) unless row['country'].blank?

    modelos.each_key do |modelo_name|
      modelos[modelo_name].each do |name|
        atributo = "#{modelo_name}_name"
        model = modelo_name.to_s.titlecase.constantize.find_or_create_by(atributo.to_sym => name)
        filme.send(modelo_name.to_s.pluralize) << model unless filme.send(modelo_name.to_s.pluralize).include?(model)
      end
    end
  end
end
