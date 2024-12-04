require 'csv'

# Service para ler arquivo CSV e inserir dados no Banco de Dados
#
class ContentFileProcessor
  attr_accessor :content_file

  def initialize(content_file)
    @content_file = content_file
  end

  def call
    file_validator = CsvValidadorService.new.valid?(@content_file)

    if !file_validator[:errors].empty?
      { success: false, errors: file_validator[:errors] }
    else
      result_transaction_service = CsvDatabaseTransactionService.new.process(@content_file)

      if !result_transaction_service[:errors].empty?
        { success: false, message: result_transaction_service[:error] }
      else
        { success: true, message: result_transaction_service[:message] }
      end
    end
  end
end
