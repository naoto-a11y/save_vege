class DropUnavailableDates < ActiveRecord::Migration[6.1]
  def change
    drop_table :unavailable_dates
  end
end
