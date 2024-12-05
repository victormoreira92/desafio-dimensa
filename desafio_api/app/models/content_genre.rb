# == Schema Information
#
# Nome de Tabela: ContentGenre
# Descrição: Modelo para representar relação de Content e Genre
#
#  id                      :integer          not null, primary key
#  content_id              :integer          not null
#  genre_id                :integer          not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
class ContentGenre < ApplicationRecord
  belongs_to :content
  belongs_to :genre
end
