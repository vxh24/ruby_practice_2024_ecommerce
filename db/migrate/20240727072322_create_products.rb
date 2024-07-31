class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.integer :stock_quantity
      t.string :image
      t.integer :category_id
      t.timestamps
    end
  end
end
