class AddProductImageIdToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :product_image_id, :integer
  end
end
