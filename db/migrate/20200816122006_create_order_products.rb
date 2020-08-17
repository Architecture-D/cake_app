class CreateOrderProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :order_products do |t|
      t.integer :product_id, null: false
      t.integer :order_id, null: false
      t.integer :purchase_price, null: false
      t.integer :quantity, null: false
      t.integer :make_status, null: false, default: 0
      

      t.timestamps
    end
  end
end
