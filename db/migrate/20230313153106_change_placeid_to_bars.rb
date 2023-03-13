class ChangePlaceidToBars < ActiveRecord::Migration[7.0]
  def change
    change_column :bars, :placeid, :string
  end
end
