require 'csv'

class CsvDatabaseTransactionService
  attr_accessor :content_file, :errors, :message

  COLUNAS_ESPERADAS = %w[show_id type title director	cast
                         country	date_added	release_year rating	duration	listed_in	description].freeze

  def initialize(content_file)
    @content_file = content_file
    @errors = []
    @message = {
      genres: 0,
      casts: 0,
      countries: 0,
      contents: 0
    }
  end

  def process
    binding.pry
    csv_file = CSV.open(@content_file.attachment_changes['file_data'].attachable[:io], headers: true).read
    csv_file.each do |row|
      criar_genres(row) if !row['listed_in'].blank?
      criar_casts(row) if !row['cast'].blank?
      criar_countries(row) if !row['country'].blank?
      criar_contents(row) if !row['title'].blank?
    end
    @message
  end

  private

  def criar_contents(row)
    if row['duration'] == 'min'
      type_duration = :minutes
    else
      type_duration = row['duration'].split(' ')[1].downcase.to_sym
    end

    type_content = row['type'].downcase.gsub(' ', '_').to_sym

    Content.transaction do
      unless Content.find_by(show_id: row['show_id'])
        Content.create!(
          title: row['title'],
          show_id: row['show_id'],
          type_content: type_content,
          description: row['description'],
          year: row['release_year'].to_i,
          duration: row['duration'].split(', ')[0],
          type_duration: type_duration
        )
        created_count += 1
      end
      @message[:content] += created_count
    end
  end

  def criar_genres(row)
    genres_names = row['listed_in'].split(', ').map(&:strip)
    created_count = 0

    Genre.transaction do
      genres_names.each do |genre_name|
        unless Genre.find_by(genre_name: genre_name)
          Genre.create(genre_name: genre_name)
          created_count += 1
        end
      end
    end
    @message[:genres] += created_count
  end

  def criar_casts(row)
    cast_names = row['cast'].split(', ').map(&:strip)
    created_count = 0
    Cast.transaction do
      cast_names.each do |cast_name|
        unless Cast.find_by(cast_name: cast_name)
          Cast.create(cast_name: cast_name)
          created_count += 1
        end
      end
    end
    @message[:casts] += created_count
  end

  def criar_countries(row)
    country_name = row['country'].split(', ').map(&:strip)
    created_count = 0

    Country.transaction do
      country_name.each do |country_name|
        unless Country.find_by(country_name: country_name)
          Country.create(country_name: country_name)
          created_count += 1
        end
      end
    end
    @message[:countries] += created_count
  end
end
