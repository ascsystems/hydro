class ProductOptionValueImage < ActiveRecord::Base
  attr_accessible :default_image, :product_image_id, :product_option_value_id

  belongs_to :product_image
  belongs_to :product_option_value

end
