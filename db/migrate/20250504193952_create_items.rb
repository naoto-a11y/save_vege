class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.references :farmer,         null: false, foreign_key: true
      t.string     :name,           null: false
      t.text       :introduction
      t.date       :available_date, null: false
      t.date       :harvest_date,   null: false
      t.integer    :price,          null: false
      t.boolean    :is_active,      null: false, default: true
      t.timestamps
    end
  end
end
