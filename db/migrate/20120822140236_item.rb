class Item < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :amount
      t.integer :order_id

      t.date :deliver_at
      t.timestamps
    end
  end
end
