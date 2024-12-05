require 'rails_helper'

RSpec.describe ContentFileProcessor, type: :service do
  let!(:csv_file) { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/arquivos/arquivo_teste.csv'), 'text/csv') }
  let!(:csv_com_outra_header) { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/arquivos/dummy.csv'), 'text/csv') }
  describe '.call' do
    context 'quando content_file é válido' do
      it 'retornar success: true e sem mensagem de erro' do
        content_file = { 'content_file_name': 'Arquivo', 'file_data': csv_file }
        response = described_class.new(content_file).send(:call)
        expect(response[:success]).to eq(true)
        expect(response[:errors]).to be_nil
      end
    end

    context 'quando o content_file é inválido' do
      it 'retornar success:false e mensagem de erro' do
        content_file = { 'content_file_name': 'Arquivo', 'file_data': csv_com_outra_header }
        response = described_class.new(content_file).send(:call)
        expect(response[:success]).to eq(false)
        expect(response[:errors]).not_to be_nil
      end
    end

  end
end
