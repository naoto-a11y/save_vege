class CreateDmMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :dm_messages do |t|

      t.references :dm_room, null: false, foreign_key: true
      t.references :sender, polymorphic: true, null: false
      t.text  :message, null: false
      t.timestamps
    end
  end
end
