class RemoveAvailableDateFromItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :items, :available_date, :date
  end
end
