class AddColumnToBars < ActiveRecord::Migration[7.0]
  def change
    add_column :bars, :name, :string
  end
end
