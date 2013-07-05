class Order < ActiveRecord::Base
  attr_accessible :address, :address2, :billing_address, :billing_address2, :billing_city, :billing_state, :billing_zip, :city, :email, :first_name, :last_name, :shipping_method_id, :state, :zip
end
