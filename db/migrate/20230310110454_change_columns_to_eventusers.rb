class ChangeColumnsToEventusers < ActiveRecord::Migration[7.0]
  def change
    change_column :event_users, :latitude, :float
    change_column :event_users, :longitude, :float
  end
end
