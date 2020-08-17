class CreateDestinations < ActiveRecord::Migration[5.2]
  def change
    create_table :destinations do |t|
      t.integer :customer_id, null: false
      t.string :post_code, null: false
      t.string :address, null: false
      t.string :name, null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.timestamps
    end
  end
end
