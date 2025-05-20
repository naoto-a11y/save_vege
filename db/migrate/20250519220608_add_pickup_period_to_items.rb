class AddPickupPeriodToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :pickup_start, :date
    add_column :items, :pickup_end, :date
  end
end
