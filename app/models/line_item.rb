class LineItem < ActiveRecord::Base

  attr_accessible :product_id, :cart_id, :quantity, :product_name

  belongs_to :product
  belongs_to :cart
  has_many :line_item_options, :dependent => :destroy

end
