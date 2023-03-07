class RenameLatitudeLongitud < ActiveRecord::Migration[7.0]
  def change
    rename_column :event_users, :user_lat, :latitude
    rename_column :event_users, :user_lng, :longitude
    rename_column :bars, :bar_lat, :latitude
    rename_column :bars, :bar_lng, :longitude
    rename_column :users, :lat, :latitude
    rename_column :users, :lng, :longitude
  end
end
