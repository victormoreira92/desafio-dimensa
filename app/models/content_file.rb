# == Schema Information
#
# Nome de Tabela: ContentFiles
# Descrição: Modelo para anexar o arquivo CSV com infromações de Content.
#
#  id                      :integer          not null, primary key
#  content_file_name       :string
#  file_data               :file
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
class ContentFile < ApplicationRecord
  has_one_attached :file_data
  validates :content_file_name, :file_data, presence: true
  validate :arquivo_com_formato_csv?

  private
  def arquivo_com_formato_csv?
    return if file_data.attached? && file_data.content_type.in?('text/csv')

    errors.add(:file_data, :tipo_arquivo_nao_permitido)
  end
end
