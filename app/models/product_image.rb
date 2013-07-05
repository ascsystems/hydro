class ProductImage < ActiveRecord::Base
  attr_accessible :name, :order_num, :product_id

  belongs_to :product

end
