class AddPrefectureToFarmers < ActiveRecord::Migration[6.1]
  def change
    add_column :farmers, :prefecture, :string
  end
end
