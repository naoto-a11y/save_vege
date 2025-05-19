class AddLatitudeAndLongitudeToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :latitude, :float
    add_column :customers, :longitude, :float
  end
end
