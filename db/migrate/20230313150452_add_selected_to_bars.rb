class AddSelectedToBars < ActiveRecord::Migration[7.0]
  def change
    add_column :bars, :selected, :boolean, default: false
  end
end
