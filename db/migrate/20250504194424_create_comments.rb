class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|

      t.references :item, null: false, foreign_key: true
      t.text :comment, null: false
      t.references :sender, polymorphic: true, null: false
      t.timestamps
    end
  end
end
