class LineItem < ActiveRecord::Base

  attr_accessible :product_id, :netsuite_id, :cart_id, :quantity, :product_name, :product_image_id, :product_price

  belongs_to :product
  belongs_to :cart
  belongs_to :product_image
  has_many :line_item_options, :dependent => :destroy

  validates :product_id, presence: true
  validates :quantity, presence: true
  validates :product_image_id, presence: true
  validates :product_price, presence: true

end
