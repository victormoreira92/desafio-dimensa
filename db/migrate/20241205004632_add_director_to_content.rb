class AddDirectorToContent < ActiveRecord::Migration[7.0]
  def change
    add_reference :contents, :director, null: true, foreign_key: { to_table: :casts }
  end
end
