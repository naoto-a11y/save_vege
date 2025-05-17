class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|

      t.references :customer,   null: false, foreign_key: true
      t.references :farmer,     null: false, foreign_key: true
      t.timestamps
    end
  end
end
