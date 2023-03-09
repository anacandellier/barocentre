class AddSpeedToEventUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :event_users, :speed, :float
    add_column :event_users, :duration, :float
    add_column :event_users, :distance, :float
  end
end
