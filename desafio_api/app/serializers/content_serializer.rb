class ContentSerializer < ActiveModel::Serializer
  attributes :id, :title, :genre, :year, :country, :published_at, :description

  def genre
    object.genres.map(&:genre_name).join(', ')
  end

  def country
    object.countries.map(&:country_name).join(', ')
  end

  def published_at
    object.published_at.strftime('%Y-%m-%d')
  end
end
