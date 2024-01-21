class CreateCategoryProducts < ActiveRecord::Migration
  def change
    create_table :categories_products do |t|
      t.references :product
      t.references :category
    end
    add_index :categories_products, :product_id
    add_index :categories_products, :category_id
  end
end
