class RenameArquivoDadoFilmeToContentFile < ActiveRecord::Migration[7.0]
  def change
    rename_table :arquivos_dados_filmes, :content_files
  end
end
