require 'rails_helper'

RSpec.describe CsvDatabaseTransactionService, type: :service do
  describe '.process' do
    context '.criar_genres' do
      it 'numeros de genres igual ao do arquivo CSV' do
        content_file = build(:content_file, :com_arquivo_teste)
        response = described_class.new(content_file).send(:process)
        expect(response[:genres]).to eq(4)
      end
    end

    context '.criar_casts' do
      it 'numeros de casts igual ao do arquivo CSV' do
        content_file = build(:content_file, :com_arquivo_teste)
        response = described_class.new(content_file).send(:process)
        expect(response[:casts]).to eq(13)
      end
    end

    context '.criar_countries' do
      it 'numeros de countries igual ao do arquivo CSV' do
        content_file = build(:content_file, :com_arquivo_teste)
        response = described_class.new(content_file).send(:process)
        expect(response[:countries]).to eq(1)
      end
    end

    context '.criar_contents' do
      it 'numeros de contents igual ao do arquivo CSV' do
        content_file = create(:content_file, :com_arquivo_teste)
        response = described_class.new(content_file.id).send(:process)
        expect(response[:contents]).to eq(4)
      end
    end

    context '.associar_content_genres_casts_countries' do
      it 'numeros de contents igual ao do arquivo CSV' do
        content_file = create(:content_file, :com_arquivo_teste)
        response = described_class.new(content_file.id).send(:process)
        expect(response[:contents]).to eq(4)
      end
    end

  end
end
