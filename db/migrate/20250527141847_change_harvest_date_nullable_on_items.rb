class ChangeHarvestDateNullableOnItems < ActiveRecord::Migration[6.1]
  def change
    change_column_null :items, :harvest_date, true
  end
end
