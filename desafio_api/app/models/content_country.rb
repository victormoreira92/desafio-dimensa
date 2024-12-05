# == Schema Information
#
# Nome de Tabela: ContentCountry
# Descrição: Modelo para representar relação de Content e Country
#
#  id                      :integer          not null, primary key
#  content_id              :integer          not null
#  country_id              :integer          not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
class ContentCountry < ApplicationRecord
  belongs_to :content
  belongs_to :country
end
