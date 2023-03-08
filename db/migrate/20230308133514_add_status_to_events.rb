class AddStatusToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :status, :integer, default: 0, index: true
    remove_column :events, :event_status
  end
end
