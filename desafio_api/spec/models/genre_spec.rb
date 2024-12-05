require 'rails_helper'

RSpec.describe Genre, type: :model do
  describe 'Validação' do
    context 'quando Genre é válido' do
      it 'com todos os dados válidos' do
        expect { create(:genre) }.to change(described_class, :count).by(1)
      end
    end

    context 'quando Genre é inválido' do
      it 'sem genre_name' do
        genre = build(:genre, genre_name: nil)
        genre.valid?
        expect(genre.errors[:genre_name]).to include('não pode ficar em branco')
      end
    end
  end
end
