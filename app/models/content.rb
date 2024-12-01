# == Schema Information
#
# Nome de Tabela: Content
# Descrição: Modelo para representar as produções cinematograficas
#           como Filme(Movie) e Serie(TV Show)
#
#  id                      :integer          not null, primary key
#  arquivo_dado_filme_id   :integer          not null, foreign key
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
  enum type_duration: { minutes: 0, season: 1}


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
