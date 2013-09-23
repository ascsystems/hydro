class ProductTranslation < ActiveRecord::Base
  attr_accessible :description, :price, :sku, :product_image_id, :quantity

  has_many :product_images

end
