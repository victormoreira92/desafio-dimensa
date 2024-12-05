require 'rails_helper'

RSpec.describe ContentFileProcessor, type: :service do
  describe '.call' do
    context 'quando content_file é válido' do
      it 'retornar success: true e sem mensagem de erro' do
        content_file = build(:content_file, :com_arquivo_csv)
        response = described_class.new(content_file).send(:call)
        expect(response[:success]).to eq(true)
        expect(response[:errors]).to be_nil
      end
    end

    context 'quando o content_file é inválido' do
      it 'retornar success:false e mensagem de erro' do
        content_file = build(:content_file, :com_arquivo_em_outro_formato)
        response = described_class.new(content_file).send(:call)
        expect(response[:success]).to eq(false)
        expect(response[:errors]).not_to be_nil
      end
    end

  end
end
