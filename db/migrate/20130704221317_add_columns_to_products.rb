class AddColumnsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :product_type_id, :integer
    add_column :products, :brand_id, :integer
  end
end
