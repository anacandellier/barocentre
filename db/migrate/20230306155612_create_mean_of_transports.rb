class CreateMeanOfTransports < ActiveRecord::Migration[7.0]
  def change
    create_table :mean_of_transports do |t|
      t.string :name
      t.float :speed

      t.timestamps
    end
  end
end
