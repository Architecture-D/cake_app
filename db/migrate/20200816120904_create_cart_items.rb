class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|
      t.integer :product_id
      t.integer :customer_id
      t.integer :quantity
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
