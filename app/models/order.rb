class Order < ActiveRecord::Base
  attr_accessor :x_ship_to_first_name, :x_ship_to_last_name, :x_ship_to_address, :x_ship_to_city, :x_ship_to_state, :x_ship_to_zip, :x_email, :credit_card_number, :exp_date, :ccv_number
  attr_accessible :credit_card_number, :address, :address2, :billing_address, :billing_address2, :billing_city, :billing_state, :billing_zip, :city, :email, :first_name, :last_name, :shipping_method_id, :state, :zip, :exp_date, :ccv_number
  has_many :line_items

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :email, presence: true
  validates :billing_address, presence: true
  validates :billing_city, presence: true
  validates :billing_state, presence: true
  validates :billing_zip, presence: true

  def shipping_method
    s = Shipping.find(self.shipping_method_id)
    s.display_text
  end

  def shipping_charge
    s = Shipping.find(self.shipping_method_id)
    s.cost.to_i == 0 ? "Free" : "$#{s.cost}"
  end

  def tax
    s = StateTaxRate.find_by_state_acronym(self.state)
    s.tax_rate
  end
end
