class RemoveTimetoEvents < ActiveRecord::Migration[7.0]
  def change
    remove_column :events, :time
    change_column :events, :date, :datetime
  end
end
