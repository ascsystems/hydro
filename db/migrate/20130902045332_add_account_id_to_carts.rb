class AddAccountIdToCarts < ActiveRecord::Migration
  def change
    # optionall association to user account
    add_column :carts, :account_id, :integer
    
    # need to keep track of shipping method on active carts also
    add_column :carts, :shipping_method_id, :integer
    
    add_index :carts, :account_id
  end
end
