class ProductTranslation < ActiveRecord::Base
  attr_accessible :description, :price, :sku, :product_image_id, :quantity

  belongs_to :product_image

end
