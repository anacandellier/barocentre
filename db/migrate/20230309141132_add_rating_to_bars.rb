class AddRatingToBars < ActiveRecord::Migration[7.0]
  def change
    add_column :bars, :rating, :integer
  end
end
