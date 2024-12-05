require 'csv'
require 'csv'

# ContentFileProcessor
# Serviço responsável por processar arquivos CSV e inserir dados no banco de dados.
#
# Este serviço realiza as seguintes etapas:
# 1. Valida o arquivo CSV utilizando `CsvValidadorService`.
# 2. Cria o registro do arquivo no banco de dados utilizando `ContentFile`.
# 3. Processa os dados do CSV e insere no banco utilizando `CsvDatabaseTransactionService`.
#
# @param content_file_params [Hash] Parâmetros do arquivo CSV a ser processado.
# @return [Hash] Retorna um hash contendo o status do processamento e possíveis mensagens de erro.
class ContentFileProcessor
  attr_accessor :content_file

  def initialize(content_file_params)
    @content_file_params = content_file_params
  end

  def call
    file_validator = CsvValidadorService.new.valid?(@content_file_params)

    if !file_validator[:errors].empty?
      { success: false, errors: file_validator[:errors] }
    else
      content_file = ContentFile.create!(@content_file_params)
      result_transaction_service = CsvDatabaseTransactionService.new(content_file).process

      if !result_transaction_service[:errors].empty?
        { success: false, errors: result_transaction_service[:errors] }
      else
        { success: true, message: result_transaction_service[:messages] }
      end
    end
  end
end
