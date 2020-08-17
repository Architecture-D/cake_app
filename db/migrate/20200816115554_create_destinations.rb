class CreateDestinations < ActiveRecord::Migration[5.2]
  def change
    create_table :destinations do |t|
      t.integer :customer_id
      t.string :post_code
      t.string :address
      t.string :name
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
