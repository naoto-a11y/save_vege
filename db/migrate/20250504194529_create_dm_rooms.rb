class CreateDmRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :dm_rooms do |t|

      t.references :reservation, null: false, foreign_key: true
      t.timestamps
    end
  end
end
