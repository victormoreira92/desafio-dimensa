class CreateContentsCasts < ActiveRecord::Migration[7.0]
  def change
    create_table :contents_casts do |t|
      t.references :content, null: false, foreign_key: true
      t.references :cast, null: false, foreign_key: true

      t.timestamps
    end
  end
end
