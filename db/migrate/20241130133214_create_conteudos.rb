class CreateConteudos < ActiveRecord::Migration[7.0]
  def change
    create_table :conteudos do |t|
      t.string :title, null: false
      t.integer :type_conteudo
      t.string :show_id
      t.datetime :published_at, null: false
      t.integer :year, null: false
      t.text :description, null: false
      t.integer :duration
      t.integer :type_duration

      t.timestamps
    end
  end
end
