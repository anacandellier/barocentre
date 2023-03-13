class ChangeSelectedToBars < ActiveRecord::Migration[7.0]
  def change
    remove_column :bars, :selected
    add_reference :events, :bar, foreign_key: true, null: true
  end
end
