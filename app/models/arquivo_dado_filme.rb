# == Schema Information
#
# Nome de Tabela: ArquivosDadosFilmes
# Descrição: Modelo para anexar o arquivo CSV com infromações de Filme.
#
#  id                      :integer          not null, primary key
#  nome_arquivo            :string
#  arquivo                 :file
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
class ArquivoDadoFilme < ApplicationRecord
  has_one_attached :arquivo
  validates :nome_arquivo, :arquivo, presence: true
  validate :arquivo_com_formato_csv?

  private
  def arquivo_com_formato_csv?
    return unless arquivo.attached? && !arquivo.content_type.in?('text/csv')

    errors.add(:arquivo, :tipo_arquivo_nao_permitido)
  end
end
