class AddProductidToOptionValues < ActiveRecord::Migration
  def change
    add_column :option_values, :product_id, :integer
  end
end
