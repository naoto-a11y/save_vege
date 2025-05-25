class RemoveLatitudeAndLongitudeFromCustomers < ActiveRecord::Migration[6.1]
  def change
    remove_column :customers, :latitude, :float
    remove_column :customers, :longitude, :float
  end
end
