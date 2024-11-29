class CreateArquivosDadosFilmes < ActiveRecord::Migration[7.0]
  def change
    create_table :arquivos_dados_filmes do |t|
      t.string :nome_arquivo

      t.timestamps
    end
  end
end
