require 'rails_helper'

RSpec.describe CsvDatabaseTransactionService, type: :service do
  let!(:csv_file) { fixture_file_upload(Rails.root.join('spec/fixtures/arquivos/arquivo_teste.csv'), 'text/csv') }

  describe '.process' do
    context '.criar_contents' do
      it 'numeros de contents igual ao do arquivo CSV' do
        content_file = create(:content_file, :com_arquivo_teste)
        response = described_class.new(content_file).send(:process)[:messages]
        expect(response[:contents]).to eq(4)
      end
    end

    context '.build_modelos' do
      it 'retornar as linhas com conteudo' do
        content_file = create(:content_file, :com_arquivo_teste)
        third_line = CSV.parse(csv_file, headers: true)[3]
        response = described_class.new(content_file).send(:build_modelos, third_line)
        expect(response).to eq({:genre=>["Documentaries"], :country=>["Chile"]})
      end
    end

    context '.parse_duration' do
      it 'deve retornar a type_duration :seasons' do
        content_file = create(:content_file, :com_arquivo_teste)
        duration = "4 Seasons"
        response = described_class.new(content_file.id).send(:parse_duration, duration)
        expect(response).to eq(:seasons)
      end

      it 'deve retornar a type_duration :minutes' do
        content_file = create(:content_file, :com_arquivo_teste)
        duration = "40 min"
        response = described_class.new(content_file.id).send(:parse_duration, duration)
        expect(response).to eq(:minutes)
      end
    end

    context '.parse_rating' do
      it 'deve retornar a type_duration :rated' do
        content_file = create(:content_file, :com_arquivo_teste)
        rating = "r"
        response = described_class.new(content_file.id).send(:parse_rating, rating)
        expect(response).to eq(:rated)
      end

      it 'deve retornar a type_duration :minutes' do
        content_file = create(:content_file, :com_arquivo_teste)
        rating = "TV-MA"
        response = described_class.new(content_file.id).send(:parse_rating, rating)
        expect(response).to eq(:tvma)
      end
    end

    context 'qunado há erro' do
      it 'type_duration com tipo errado' do
        content_file = create(:content_file, :com_arquivo_teste)
        line = CSV.parse(csv_file, headers: true)[2]
        line['type'] = 'TV Show'
        line['duration'] = '10 min'
        response = described_class.new(content_file).send(:criar_contents, line)
        expect(response).to include("Erro ao criar: #{ line['show_id'] }: A validação falhou: Tipo de duration é inválido")
      end
    end

  end
end
