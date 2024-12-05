require 'rails_helper'

RSpec.describe Cast, type: :model do
  describe 'Validação' do
    context 'quando Cast é válido' do
      it 'com todos os dados válidos' do
        expect { create(:cast) }.to change(described_class, :count).by(1)
      end
    end

    context 'quando Cast é inválido' do
      it 'sem cast_name' do
        cast = build(:cast, cast_name: nil)
        cast.valid?
        expect(cast.errors[:cast_name]).to include('não pode ficar em branco')
      end
    end
  end
end
