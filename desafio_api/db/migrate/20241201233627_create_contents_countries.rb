class CreateContentsCountries < ActiveRecord::Migration[7.0]
  def change
    create_table :contents_countries do |t|
      t.references :content, null: false, foreign_key: true
      t.references :country, null: false, foreign_key: true

      t.timestamps
    end
  end
end
