require 'rails_helper'

RSpec.describe ArquivoDadoFilme, type: :model do
  describe 'Validações' do
    context 'quando ArquivoDadoFilme é válido' do
      it 'com todos os atributos preenchidos' do
        expect { create(:arquivo_dado_filme, :com_arquivo_csv) }.to change(described_class, :count).by(1)
      end
    end
    context 'quando ArquivoDadoFilme não é válido' do
      it 'sem nome_arquivo' do
        arquivo_dado_filme = build(:arquivo_dado_filme, :com_arquivo_csv, nome_arquivo: nil)
        arquivo_dado_filme.valid?
        expect(arquivo_dado_filme.errors[:nome_arquivo]).to include('não pode ficar em branco')
      end

      it 'sem arquivo' do
        arquivo_dado_filme = build(:arquivo_dado_filme, arquivo: nil)
        arquivo_dado_filme.valid?
        expect(arquivo_dado_filme.errors[:arquivo]).to include('não pode ficar em branco')
      end

      it 'arquivo com outro diferente de CSV' do
        arquivo_dado_filme = build(:arquivo_dado_filme, :com_arquivo_em_outro_formato)
        arquivo_dado_filme.valid?
        expect(arquivo_dado_filme.errors[:arquivo]).to include(I18n.t('activerecord.errors.models.arquivo_dado_filme.attributes.arquivo.tipo_arquivo_nao_permitido'))
      end
    end
  end
end
