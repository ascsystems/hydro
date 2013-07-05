class AddColumnsToOptionTypes < ActiveRecord::Migration
  def change
    add_column :option_types, :product_type_id, :integer
  end
end
