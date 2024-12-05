require 'rails_helper'

RSpec.describe Content, type: :model do

  describe 'Associações' do
    it { should have_many(:contents_casts) }
    it { should have_many(:contents_genres) }
    it { should have_many(:contents_countries) }
  end

  describe 'Validações' do
    context 'quando o Content é válido' do
      it 'com todos os atributos' do
        expect { create(:content) }.to change(described_class, :count).by(1)
      end
    end

    context 'quando Content é inválido' do
      %w[title published_at year description].each do |atributo|
        it "sem #{I18n.t("activerecord.attributes.content.#{atributo}")}" do
          content = build(:content, "sem_#{atributo}".to_sym)
          content.valid?
          expect(content.errors[atributo.to_sym]).to include('não pode ficar em branco')
        end
      end
      it 'content do tipo Movie com duration season' do
        content = build(:content, type_duration: :seasons)
        content.valid?
        expect(content.errors[:base]).to include(I18n.t('activerecord.errors.models.content.attributes.base.content_com_duration_invalido'))
      end

      it 'content do tipo Tv Show com duration minutes' do
        content = build(:content, :tv, type_duration: :minutes)
        content.valid?
        expect(content.errors[:base]).to include(I18n.t('activerecord.errors.models.content.attributes.base.content_com_duration_invalido'))
      end
    end
  end

  describe 'scope' do
    let!(:genre) { create(:genre) }
    let!(:cast) { create(:cast) }
    let!(:country) { create(:country) }
    let!(:content) { create(:content) }
    let!(:content_tv) { create(:content, :tv) }

    it '#by_genre' do
      content.genres << genre
      expect(described_class.by_genre(genre.genre_name)).to include(content)
    end

    it '#by_cast' do
      content.casts << cast
      expect(described_class.by_cast(cast.cast_name)).to include(content)
    end

    it '#by_country' do
      content.countries << country
      expect(described_class.by_country(country.country_name)).to include(content)
    end

    it '#by_title' do
      expect(described_class.by_title(content.title)).to include(content)
    end

    it '#by_genre' do
      content.update(year: 2004)
      expect(described_class.by_year_range(2001, 2004)).to include(content)
    end
  end
end
