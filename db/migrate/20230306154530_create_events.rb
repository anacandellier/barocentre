class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.datetime :time
      t.string :name
      t.float :barycenter_lng
      t.float :barycenter_lat
      t.string :event_status

      t.timestamps
    end
  end
end
