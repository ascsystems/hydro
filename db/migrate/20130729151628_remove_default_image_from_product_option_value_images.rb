class RemoveDefaultImageFromProductOptionValueImages < ActiveRecord::Migration
  def up
    remove_column :product_option_value_images, :default_image
  end

  def down
    add_column :product_option_value_images, :default_image, :integer
  end
end
