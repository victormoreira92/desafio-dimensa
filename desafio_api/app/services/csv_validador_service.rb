require 'csv'

class CsvValidadorService
  COLUNAS_ESPERADAS = %w[show_id type title director	cast
                         country	date_added	release_year
                         rating	duration	listed_in	description].freeze

  def initialize
    @errors = []
  end

  def valid?(content_file)
    unless validar_modelo_content_file(content_file)
      validar_csv_vazio(content_file)
      validar_headers(content_file)
    end

    { errors: @errors.flatten }
  end

  private

  def validar_modelo_content_file(content_file_params)
    arquivo_dados = ContentFile.new(content_file_params)
    unless arquivo_dados.valid?
      @errors.append(arquivo_dados.errors.full_messages.join(', '))
    end
  end

  def validar_csv_vazio(content_file)
    csv = CSV.read(content_file['file_data'].path, headers: true)
    @errors << I18n.t('activerecord.errors.models.content_file.attributes.base.csv_vazio') if csv.empty?
  end

  def validar_headers(content_file)
    headers_de_arquivo = CSV.open(content_file['file_data'].path, headers: true).read.headers
    colunas_faltando = COLUNAS_ESPERADAS - headers_de_arquivo
    if colunas_faltando.any?
      @errors << I18n.t('activerecord.errors.models.content_file.attributes.base.arquivo_com_headers_diferente',
                        colunas: colunas_faltando.join(', '))
    end
  end
end
