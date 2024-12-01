require 'rails_helper'

RSpec.describe Conteudo, type: :model do
  describe 'Validações' do
    context 'quando o Conteudo é válido' do
      it 'com todos os atributos' do
        expect { create(:conteudo) }.to change(described_class, :count).by(1)
      end
    end

    context 'quando Conteudo é inválido' do
      %w[title published_at year description].each do |atributo|
        it "sem #{I18n.t("activerecord.attributes.conteudo.#{atributo}")}" do
          conteudo = build(:conteudo, "sem_#{atributo}".to_sym)
          conteudo.valid?
          expect(conteudo.errors[atributo.to_sym]).to include('não pode ficar em branco')
        end
      end
      it 'Conteudo do tipo Movie com duration season' do
        conteudo = build(:conteudo, type_duration: :season)
        conteudo.valid?
        expect(conteudo.errors[:base]).to include(I18n.t('activerecord.errors.models.conteudo.attributes.base.conteudo_com_duration_invalido'))
      end

      it 'Conteudo do tipo Tv Show com duration minutes' do
        conteudo = build(:conteudo,:tv_show, type_duration: :minutes)
        conteudo.valid?
        expect(conteudo.errors[:base]).to include(I18n.t('activerecord.errors.models.conteudo.attributes.base.conteudo_com_duration_invalido'))
      end
    end
  end
end
