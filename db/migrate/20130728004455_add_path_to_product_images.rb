class AddPathToProductImages < ActiveRecord::Migration
  def change
    add_column :product_images, :path, :string
  end
end
