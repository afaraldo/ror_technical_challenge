class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.references :client
      t.references :product
      t.integer :quantity
      t.integer :unit_price
      t.integer :total

      t.timestamps
    end
    add_index :purchases, :client_id
    add_index :purchases, :product_id
  end
end
