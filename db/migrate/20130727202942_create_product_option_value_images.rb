class CreateProductOptionValueImages < ActiveRecord::Migration
  def change
    create_table :product_option_value_images do |t|
      t.integer :product_option_value_id
      t.integer :product_image_id
      t.integer :default_image

      t.timestamps
    end
  end
end
