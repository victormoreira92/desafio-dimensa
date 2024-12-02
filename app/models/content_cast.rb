# == Schema Information
#
# Nome de Tabela: ContentsCasts
# Descrição: Modelo para representar a relação Content e Cast
#
#  id                      :integer          not null, primary key
#  content_id              :integer          not null, foreign key
#  cast_id                 :integer          not null, foreign key
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
class ContentCast < ApplicationRecord
  belongs_to :content
  belongs_to :cast
end
