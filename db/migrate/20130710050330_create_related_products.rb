class CreateRelatedProducts < ActiveRecord::Migration
  def change
    create_table :related_products do |t|
      t.integer :product_id
      t.integer :related_product_id
      t.integer :order_num

      t.timestamps
    end
  end
end
