class AddCancellationReasonToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :cancellation_reason, :integer
  end
end
