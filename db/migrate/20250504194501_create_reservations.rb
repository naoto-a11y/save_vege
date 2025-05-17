class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|

      t.references :customer, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.date :reserved_date, null: false
      t.timestamps
    end
  end
end
