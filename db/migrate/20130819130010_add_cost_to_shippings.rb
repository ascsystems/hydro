class AddCostToShippings < ActiveRecord::Migration
  def change
    add_column :shippings, :cost, :float
  end
end
