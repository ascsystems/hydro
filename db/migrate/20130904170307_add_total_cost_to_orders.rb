class AddTotalCostToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :payment_total_cost, :decimal, :precision => 8, :scale => 2
  end
end
