class Order < ActiveRecord::Base
  attr_accessor :x_ship_to_first_name, :x_ship_to_last_name, :x_ship_to_address, :x_ship_to_city,
                :x_ship_to_state, :x_ship_to_zip, :x_email, :x_invoice_number, :credit_card_number,
                :ccv_number, :total_amount, :cc_expiry_month, :cc_expiry_year
  attr_accessible :first_name, :last_name, :credit_card_number, :address, :address2, :city, :state, :zip, :email, 
                   :billing_address, :billing_address2, :billing_city, :billing_state, :billing_zip, 
                  :shipping_method_id, :invoice_number, :status, :account_id, :ccv_number, :total_amount,
                  :cc_expiry_month, :cc_expiry_year, :payment_total_cost
  
              
  has_many :line_items
  belongs_to :account  # optional linkage (an order can be done by a "guest" not signed in)
  belongs_to :shipping, :foreign_key => 'shipping_method_id'

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
  
  # NOTE: there is a special validation method for the CC info,
  #       since that data is not saved to the DB. (see validate_cc_fields)
  
  
  # NOTE:
  # These values are submitted into the database table, so if they ever change,
  # you would need to do a bulk change on the orders table to change all matching
  # orders from the old status name to the new status name.
  ORDER_INITIATED = 'INITIATED'
  ORDER_COMPLETED = 'COMPLETED'
  ORDER_FAILED = 'FAILED'
  
  MONTHS_FOR_EXPIRY = [['01', '01'], ['02', '02'], ['03', '03'], ['04', '04'], ['05', '05'], ['06', '06'], 
                      ['07', '07'], ['08', '08'], ['09', '09'], ['10', '10'], ['11', '11'], ['12', '12']]
  
  after_create :set_invoice_number
  
  # Create incrementing invoice number (starting at 777777)
  def set_invoice_number
    self.invoice_number = self.id + 777777
    self.status = ORDER_INITIATED
    self.save
  end
  
  # Validate the credit card fields (this is only called at certain points from the controller)
  def validate_cc_fields!
    #NOTE: these errors don't show up if they are added to individual virtual fields, so I've added them to :base
    self.errors.add(:credit_card_number, "Credit card number is required." ) unless self.credit_card_number.present?
    self.errors.add(:ccv_number, "CCV number is required." ) unless self.ccv_number.present?
    self.errors.add(:cc_expiry_month, "Credit card expiry month is required." ) unless self.cc_expiry_month.present?
    self.errors.add(:cc_expiry_year, "Credit card expiry year is required." ) unless self.cc_expiry_year.present?
  end

  #FIXME: not used
  def shipping_method
    #shipping = Shipping.find(self.shipping_method_id)
    self.shipping.display_text
  end

  #FIXME: not used
  def shipping_charge
    #shipping = Shipping.find(self.shipping_method_id)
    shipping_cost = shipping.cost
    shipping_cost.to_i == 0 ? "Free" : "$#{shipping_cost}"
  end

  def tax
    s = StateTaxRate.find_by_state_acronym(self.state)
    s.tax_rate
  end

  def tax_amount
    tax = self.total_amount.to_f * (self.tax.to_f/100)
    tax.round(2)
  end

  def make_payment
    payment_handler = PaymentHandler::Billing.new(AUTHORIZE_CONFIG['api_login_id'],AUTHORIZE_CONFIG['transaction_key'], AUTHORIZE_CONFIG['gateway'])
    
    # Communicate with authorize.net API to actually make the payment
    payment_handler.make_payment(self)
  end
  
  #---------------------------------------------------------------------------
  # For each line_item in the current card, associate that line item to this order.
  def accociate_cart_line_items(the_cart)
    the_cart.line_items.each do |a_line_item|
      self.line_items << a_line_item  # LineItem row is saved, with our order_id
    end
  end
  #---------------------------------------------------------------------------
  
  
  #---------------------------------------------------------------------------
  # Helper method that copied shipping address hash values to billing address
  def self.set_billing_same_as_shipping(order_params)
    billing_params = {}
    billing_params[:billing_address] = order_params[:address]
    billing_params[:billing_address2] = order_params[:address2]
    billing_params[:billing_city] = order_params[:city]
    billing_params[:billing_state] = order_params[:state]
    billing_params[:billing_zip] = order_params[:zip]
    billing_params
  end
  #---------------------------------------------------------------------------
  
  # This must remainin in this format -- it's used in the payment_hander CC api
  # mmYY string
  def cc_expiry
    self.cc_expiry_month + self.cc_expiry_year
  end
  
  #---------------------------------------------------------------------------
  # Construct array of upcoming years, for use in the expiry year dropdown
  def self.years_for_expiry
    array_of_years = []
    
    now_date = Time.now.to_date
    first_year_allowed = now_date.year
    
    # Build array of 2 digit upcoming years
    # eg. [14..24].each do ...
    (first_year_allowed..(first_year_allowed + 10)).each do |the_year|
      array_of_years << ([the_year.to_s, (the_year - 2000).to_s])
    end
    array_of_years
  end
  #---------------------------------------------------------------------------
  
  # Create a Date object from the "<mm><YY>" exp_date value (so it can be used in the form)
  #def exp_date_as_date(four_digit_exp_date)
  #  # Change the 2 digit year to 4 digit
  #  four_digit_year = (four_digit_exp_date[2..3]).to_i + 2000
  #  
  #  # Date.new(year, month, day);  we don't care about the day
  #  return Date.new( four_digit_year, four_digit_exp_date[0..1].to_i, 1)
  #end
  
  # Create "<mm><YY>" exp_date string, from the Date value
  #def exp_date_as_four_digits
  #  month_with_leading_zero = "%02d" % exp_date.month
  #  year_as_two_digits = exp_date.year - 2000
  #  month_and_year = "#{month_with_leading_zero}#{year_as_two_digits}"
  #end
  
end
