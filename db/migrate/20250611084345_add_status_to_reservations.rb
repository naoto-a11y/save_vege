class AddStatusToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :status, :integer, default: 0, null: false
  end
end
