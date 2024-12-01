require 'rails_helper'

RSpec.describe Country, type: :model do
  describe 'Validação' do
    context 'quando Country é válido' do
      it 'com todos os dados válidos' do
        expect { create(:country) }.to change(described_class, :count).by(1)
      end
    end

    context 'quando Country é inválido' do
      it 'sem country_name' do
        country = build(:country, country_name: nil)
        country.valid?
        expect(country.errors[:country_name]).to include('não pode ficar em branco')
      end
    end
  end
end
