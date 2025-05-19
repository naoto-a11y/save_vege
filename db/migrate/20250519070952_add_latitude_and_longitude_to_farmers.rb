class AddLatitudeAndLongitudeToFarmers < ActiveRecord::Migration[6.1]
  def change
    add_column :farmers, :latitude, :float
    add_column :farmers, :longitude, :float
  end
end
