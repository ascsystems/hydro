class AddProductTypeIdToOptions < ActiveRecord::Migration
  def change
    add_column :options, :product_type_id, :integer
  end
end
