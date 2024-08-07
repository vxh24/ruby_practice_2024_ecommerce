class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :receiver_info, null: false, foreign_key: true
      t.decimal :total_price, precision: 10, scale: 2
      t.datetime :date_place_order
      t.string :status
      t.string :payment_option

      t.timestamps
    end
  end
end
