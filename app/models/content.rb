# == Schema Information
#
# Nome de Tabela: Content
# Descrição: Modelo para representar as produções cinematograficas
#           como Filme(Movie) e Serie(TV Show)
#
#  id                      :integer          not null, primary key
#  content_file_id         :integer          not null, foreign key
#  title                   :string           not null
#  show_id                 :string
#  published_at            :datetime         not null
#  year                    :integer          not null
#  description             :text             not null
#  duration                :integer
#  type_duration           :integer(enum)
#  type_content           :intger(enum)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
class Content < ApplicationRecord
  enum type_content: { movie: 0, tv_show: 1 }
  enum type_duration: { minutes: 0, seasons: 1}

  belongs_to :content_file

  has_many :contents_casts
  has_many :casts, through: :contents_casts

  has_many :contents_genres
  has_many :genres, through: :contents_genres

  has_many :contents_countries
  has_many :countries, through: :contents_countries

  validates :title, :published_at, :year, :description, presence: true
  validate :validar_type_content_e_type_duration

  private

  def validar_type_content_e_type_duration
    content_duration = {
      movie: 'minutes',
      tv_show: 'season'
    }.freeze
    errors.add(:base, :content_com_duration_invalido) unless content_duration[type_content.to_sym] == type_duration
  end
end
