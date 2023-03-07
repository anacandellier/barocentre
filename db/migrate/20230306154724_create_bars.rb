class CreateBars < ActiveRecord::Migration[7.0]
  def change
    create_table :bars do |t|
      t.float :distance
      t.integer :nb_votes
      t.float :bar_lat
      t.float :bar_lng
      t.datetime :opening_hours
      t.string :address

      t.timestamps
    end
  end
end
