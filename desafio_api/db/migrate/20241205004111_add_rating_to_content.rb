class AddRatingToContent < ActiveRecord::Migration[7.0]
  def change
    add_column :contents, :rating, :integer
  end
end
