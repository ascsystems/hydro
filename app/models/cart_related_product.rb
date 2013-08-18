class CartRelatedProduct < ActiveRecord::Base
  attr_accessible :product_id, :related_product_id

  belongs_to :product
  belongs_to :related_product, class_name: :Product

  def self.related_products
    #if self.related_products.empty?
      return Product.find(3,4,1,2)
    #else
    #  return self.related_products
    #end
  end

end