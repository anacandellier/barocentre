class AddPlaceidToBars < ActiveRecord::Migration[7.0]
  def change
    add_column :bars, :placeid, :integer
  end
end
