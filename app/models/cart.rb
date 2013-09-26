class Cart < ActiveRecord::Base
  
  attr_accessible :shipping_method_id, :account_id
  
  has_many :line_items, :dependent => :destroy
  belongs_to :account
  belongs_to :shipping, :foreign_key => 'shipping_method_id'

  accepts_nested_attributes_for :line_items

  def add_product(product, options, quantity)
    if(!quantity.present? || quantity.to_i < 1)
      quantity = 1
    end
    current_item = self.return_item(product, options)
    if current_item != nil
     current_item.quantity = current_item.quantity + quantity
    else
      pi = ProductImage.new
      if(!options)
        current_image = pi.getCartImage([], product.id)
      else
        current_image = pi.getCartImage(options.values, product.id)
      end
      current_image = current_image.first
      current_item = line_items.build(product_id: product.id, product_name: product.name, quantity: quantity, product_image_id: current_image.id, netsuite_id: current_image.product_translation.netsuite_id, product_price: product.price)
      if(options.present?)
        current_options = OptionValue.find_all_by_id(options.values)
        current_options.each do |o|
          current_item.line_item_options.build(option_id: o.id, option_name: o.name)
        end
      end
    end
    current_item
  end

  def return_item(product, options)
    current_item = self.line_items.all(conditions: ['line_item_options.option_id IN (?) and line_items.product_id = ?', options.values, product.id], include: :line_item_options, group: 'line_items.id', having: ['COUNT(distinct line_item_options.option_id) >= ?', options.length]).first
    return current_item
  end

end