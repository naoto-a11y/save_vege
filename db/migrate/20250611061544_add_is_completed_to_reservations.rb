class AddIsCompletedToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :is_completed, :boolean, default: false, null: false
  end
end
