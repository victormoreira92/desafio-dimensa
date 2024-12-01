# == Schema Information
#
# Nome de Tabela: Country
# Descrição: Modelo para representar os países(country)
#
#  id                      :integer          not null, primary key
#  country_name            :string           not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
class Country < ApplicationRecord
  validates :country_name, presence: true
end