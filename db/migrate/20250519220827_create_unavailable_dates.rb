class CreateUnavailableDates < ActiveRecord::Migration[6.1]
  def change
    create_table :unavailable_dates do |t|
      t.references :item, null: false, foreign_key: true
      t.date :date

      t.timestamps
    end
  end
end
