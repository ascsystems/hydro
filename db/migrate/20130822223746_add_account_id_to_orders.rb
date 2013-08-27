class AddAccountIdToOrders < ActiveRecord::Migration
  def change
    # need to be able to link orders back to customer accounts efficiently
    add_column :orders, :account_id, :integer
    
    add_index :orders, :account_id
  end
end
