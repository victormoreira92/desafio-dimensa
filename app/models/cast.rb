# == Schema Information
#
# Nome de Tabela: Casts
# Descrição: Modelo para representar tanto o elenco tanto
#            atores como diretores(cast, director)
#
#  id                      :integer          not null, primary key
#  cast_name                :string          not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
class Cast < ApplicationRecord
  validates :cast_name, presence: true
end
