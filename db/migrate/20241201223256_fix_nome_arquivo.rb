class FixNomeArquivo < ActiveRecord::Migration[7.0]
  def change
    rename_column :content_files, :nome_arquivo, :content_file_name
  end
end
