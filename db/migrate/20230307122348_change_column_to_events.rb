class ChangeColumnToEvents < ActiveRecord::Migration[7.0]
  def change
    change_column :events, :time, :time
    add_column :events, :date, :date
  end
end
