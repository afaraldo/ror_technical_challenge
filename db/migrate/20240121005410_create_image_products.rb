class CreateImageProducts < ActiveRecord::Migration
  def change
    create_table :images_products do |t|
      t.references :product
      t.references :image
    end
    add_index :images_products, :product_id
    add_index :images_products, :image_id
  end
end
