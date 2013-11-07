class ProductImage < ActiveRecord::Base
  attr_accessible :name, :product_id, :product_translation_id, :path, :default_image

  belongs_to :product
  belongs_to :product_translation
  has_many :product_option_value_images
  has_many :product_option_values, through: :product_option_value_images
  has_many :line_items

  def getImage(options, product_id)
  	if(options.empty? == false)
      image = ProductImage.all(conditions: ['product_option_values.id IN (?) and product_images.product_id = ?', options, product_id], joins: [:product_option_values, :product_translation], group: 'product_images.id', having: ['COUNT(distinct product_option_values.id) >= ?', options.length])
  		if(image.empty? == false)
        return image
      end
    end
    product = Product.find(product_id)
    return [product.product_image]
  end

  #getCartImage is different than getImage based on the caps chosen(needs logic added)
  def getCartImage(options, product_id) 
    if(options.empty? == false)
      image = ProductImage.all(conditions: ['product_option_values.id IN (?) and product_images.product_id = ?', options, product_id], joins: [:product_option_values, :product_translation], group: 'product_images.id', having: ['COUNT(distinct product_option_values.id) >= ?', options.length])
      if(image.empty? == false)
        return image
      end
    end
    product = Product.find(product_id)
    return [product.product_image]
  end

end
