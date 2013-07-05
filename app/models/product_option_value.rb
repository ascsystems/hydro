class ProductOptionValue < ActiveRecord::Base
  attr_accessible :option_value_id, :price, :product_id

  belongs_to :product
  belongs_to :option_values

end
