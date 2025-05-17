class CreateAvailableSlots < ActiveRecord::Migration[6.1]
  def change
    create_table :available_slots do |t|
      t.references :item, null: false, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
