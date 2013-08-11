class AddProductNameToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :product_name, :string
  end
end
