class CreateReceiverInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :receiver_infos do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :phone
      t.string :address

      t.timestamps
    end
  end
end
