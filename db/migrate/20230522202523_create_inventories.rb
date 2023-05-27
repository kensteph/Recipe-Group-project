class CreateInventories < ActiveRecord::Migration[7.0]
  def change
    create_table :inventories do |t|
      t.string :name , unique: true
      t.text :description , null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
