class ReplaceMeansToEventusers < ActiveRecord::Migration[7.0]
  def change
    remove_column :event_users, :mean_of_transport_id
    drop_table :mean_of_transports
    add_column :event_users, :transport, :string
  end
end
