class CreateContentsGenres < ActiveRecord::Migration[7.0]
  def change
    create_table :contents_genres do |t|
      t.references :content, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
