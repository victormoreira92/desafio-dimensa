require 'csv'

# Service para ler arquivo CSV e inserir dados no Banco de Dados
#
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
