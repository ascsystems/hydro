class RemovePriceFromOptionValues < ActiveRecord::Migration
  def up
    remove_column :option_values, :price
    remove_column :option_values, :product_id
  end

  def down
    add_column :option_values, :product_id, :integer
    add_column :option_values, :price, :decimal
  end
end
