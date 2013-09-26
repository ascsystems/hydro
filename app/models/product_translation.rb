class ProductTranslation < ActiveRecord::Base
  attr_accessible :description, :price, :sku, :netsuite_id, :quantity, :weight

  has_many :product_images

end
