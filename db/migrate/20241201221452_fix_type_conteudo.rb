class FixTypeConteudo < ActiveRecord::Migration[7.0]
  def change
    rename_column :contents, :type_conteudo, :type_content
  end
end
