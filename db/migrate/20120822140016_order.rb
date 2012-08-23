class Order < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.decimal :amount
      t.date :deliver_at
      t.timestamps
    end
  end
end
