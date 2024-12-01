# == Schema Information
#
# Nome de Tabela: Genre
# Descrição: Modelo para representar os generos(genres) das produções
#
#  id                      :integer          not null, primary key
#  country_name            :string           not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
class Genre < ApplicationRecord
  validates :genre_name, presence: true
end
