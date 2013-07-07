class OptionValue < ActiveRecord::Base
  attr_accessible :name, :option_id, :display_data, :order_num

  belongs_to :option
  has_many :product_option_values
  has_many :products, through: :product_option_values
 
  validates :name, presence: true
  validates :option_id, presence:true

end
