class RemovePickupDatesFromItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :items, :pickup_start, :date
    remove_column :items, :pickup_end, :date
  end
end
