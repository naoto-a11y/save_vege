class AddIntroductionToFarmersAndCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :farmers, :introduction, :text
    add_column :customers, :introduction, :text
  end
end
