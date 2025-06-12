class RemoveIsCompletedFromReservations < ActiveRecord::Migration[6.1]
  def change
    remove_column :reservations, :is_completed, :boolean
  end
end
