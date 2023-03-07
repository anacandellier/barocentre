class AddReferenceToBars < ActiveRecord::Migration[7.0]
  def change
    add_reference :bars, :event, index: true
  end
end
