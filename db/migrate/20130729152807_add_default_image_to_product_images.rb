class AddDefaultImageToProductImages < ActiveRecord::Migration
  def change
    add_column :product_images, :default_image, :integer
  end
end
