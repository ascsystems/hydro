class Cart < ActiveRecord::Base
  
  attr_accessible :shipping_method_id, :account_id
  
  has_many :line_items, :dependent => :destroy
  belongs_to :account
  belongs_to :shipping, :foreign_key => 'shipping_method_id'

  accepts_nested_attributes_for :line_items

  def add_product(product, options, quantity)
    additional_products = []
    standard_options = []
    if(options.present?)
      current_options = OptionValue.find_all_by_id(options.values)
      current_options.each do |o|
        if o.option_id == 3
          additional_products.push(o.product_id)
        else
          standard_options.push(o.id)
        end
      end
    end
    if(!quantity.present? || quantity.to_i < 1)
      quantity = 1
    end
    current_item = self.return_item(product, standard_options)
    if current_item != nil
     current_item.quantity = current_item.quantity + quantity.to_i
     quantity = current_item.quantity
    else
      pi = ProductImage.new
      #if(!options)
      #  current_image = pi.getCartImage([], product.id)
      #else
      current_image = pi.getCartImage(standard_options, product.id)
      #end
      current_image = current_image.first
      current_item = line_items.build(product_id: product.id, product_name: product.name, quantity: quantity.to_i, product_image_id: current_image.id, netsuite_id: current_image.product_translation.netsuite_id, product_price: product.price, product_subtotal: product.price * quantity.to_i)
      if(current_options.present?)
        #current_options = OptionValue.find_all_by_id(options.values)
        current_options.each do |o|
          if o.option_id != 3
            current_item.line_item_options.build(option_id: o.id, option_name: o.name, option_type: o.option.name, option_type_id: o.option.id)
          end
        end
      end
      if additional_products.length > 0
        additional_products.each do |ap|
          a_product = Product.find(ap)
          a_item = self.add_product(a_product, nil, quantity)
          a_item.save
        end
      end
    end
    self.set_subtotal
    current_item
  end

  def set_subtotal
    subtotal = 0
    self.line_items.each do |li|
      subtotal += li.product_subtotal.to_f
    end
    self.update_attribute(:subtotal, subtotal) 
  end

  def return_item(product, options)
    current_item = self.line_items.all(conditions: ['line_item_options.option_id IN (?) and line_items.product_id = ?', options, product.id], include: :line_item_options, group: 'line_items.id', having: ['COUNT(distinct line_item_options.option_id) >= ?', options.length]).first
    return current_item
  end

end