require 'rails_helper'

RSpec.describe CsvValidadorService, type: :service do
  describe '.validar_modelo_content_file' do
    context 'quando objeto é válido' do
      it 'com content_file_name e com arquivo_csv' do
        content_file = build(:content_file, :com_arquivo_csv)
        expect(described_class.new.send(:validar_modelo_content_file, content_file)).to be_nil
      end
    end

    context 'objeto inválido retorna erro' do
      it 'quando esta sem content_file_name' do
        content_file = build(:content_file, :com_arquivo_csv, content_file_name: nil)
        expect(described_class.new.send(:validar_modelo_content_file, content_file)).to include('Nome de Arquivo não pode ficar em branco')
      end
      it 'quando esta com arquivo em formato diferente de CSV' do
        content_file = build(:content_file, :com_arquivo_em_outro_formato)
        expect(described_class.new.send(:validar_modelo_content_file, content_file)).to include('Arquivo de Dados não está em formato CSV')
      end
    end

  end

  describe '.validar_csv_vazio' do
    it 'é válido se objeto tiver csv com algum conteúdo' do
      content_file = build(:content_file, :com_arquivo_csv)
      expect(described_class.new.send(:validar_csv_vazio, content_file)).to be_nil
    end

    it 'é inválido se objeto tiver csv com conteúdo vazio' do
      content_file = build(:content_file, :com_arquivo_csv_vazio)
      expect(described_class.new.send(:validar_csv_vazio, content_file)).to include(I18n.t('activerecord.errors.models.content_file.attributes.base.csv_vazio'))
    end
  end

  describe '.validar_headers' do
    it 'é válido se o objeto é possui as headers de arquivo modelo' do
      content_file = build(:content_file, :com_arquivo_csv)
      expect(described_class.new.send(:validar_headers, content_file)).to be_nil
    end

    it 'é inválido se o objeto é possui as headers diferentes de arquivo modelo' do
      content_file = build(:content_file, :com_arquivo_csv_com_headers_diferente)
      colunas_faltando = %w[show_id type title director	cast
                            country	date_added	release_year
                            rating	duration	listed_in	description]
      expect(described_class.new.send(:validar_headers, content_file)).to include(I18n.t('activerecord.errors.models.content_file.attributes.base.arquivo_com_headers_diferente', colunas: colunas_faltando.join(', ') ))
    end
  end
end
