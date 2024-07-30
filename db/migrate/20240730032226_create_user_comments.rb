class CreateUserComments < ActiveRecord::Migration[7.0]
  def change
    create_table :user_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :order_detail, null: false, foreign_key: true
      t.text :content
      t.integer :rating

      t.timestamps
    end
  end
end
