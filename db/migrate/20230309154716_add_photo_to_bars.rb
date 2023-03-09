class AddPhotoToBars < ActiveRecord::Migration[7.0]
  def change
    add_column :bars, :photo, :string
  end
end
