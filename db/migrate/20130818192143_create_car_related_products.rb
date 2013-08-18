class CreateCarRelatedProducts < ActiveRecord::Migration
  def change
    create_table :car_related_products do |t|
      t.string :product_id
      t.string :related_product_id

      t.timestamps
    end
  end
end
