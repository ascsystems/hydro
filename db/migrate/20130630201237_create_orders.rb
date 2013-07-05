class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.integer :shipping_method_id
      t.string :billing_first_name
      t.string :billing_last_name
      t.string :billing_address
      t.string :billing_address2
      t.string :billing_city
      t.string :billing_state
      t.string :billing_zip

      t.timestamps
    end
  end
end
