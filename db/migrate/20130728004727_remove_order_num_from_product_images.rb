class RemoveOrderNumFromProductImages < ActiveRecord::Migration
  def up
    remove_column :product_images, :order_num
  end

  def down
    add_column :product_images, :order_num, :integer
  end
end
