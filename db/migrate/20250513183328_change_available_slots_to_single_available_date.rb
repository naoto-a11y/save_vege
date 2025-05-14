class ChangeAvailableSlotsToSingleAvailableDate < ActiveRecord::Migration[6.1]
  def change
    remove_column :available_slots, :end_time, :datetime
    rename_column :available_slots, :start_time, :available_date
  end
end
