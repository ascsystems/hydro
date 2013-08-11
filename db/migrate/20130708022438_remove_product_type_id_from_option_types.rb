class RemoveProductTypeIdFromOptionTypes < ActiveRecord::Migration
  def up
    remove_column :option_types, :product_type_id
  end

  def down
    add_column :option_types, :product_type_id, :integer
  end
end
