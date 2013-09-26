class ProductOptionValue < ActiveRecord::Base
  attr_accessible :option_value_id, :price, :product_id, :order_num

  belongs_to :product
  belongs_to :option_value

end
