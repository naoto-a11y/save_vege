class ChangeTelephoneNumberToStringInCustomers < ActiveRecord::Migration[6.1]
  def change
    change_column :customers, :telephone_number, :string
  end
end
