class CreateEventUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :event_users do |t|
      t.string :user_address
      t.string :user_lat
      t.string :user_lng
      t.references :mean_of_transport, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
