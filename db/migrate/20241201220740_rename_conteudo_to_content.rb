class RenameConteudoToContent < ActiveRecord::Migration[7.0]
  def change
    rename_table :conteudos, :contents
  end
end
