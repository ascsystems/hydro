class Order < ActiveRecord::Base
  attr_accessor :x_ship_to_first_name, :x_ship_to_last_name, :x_ship_to_address, :x_ship_to_city,
                :x_ship_to_state, :x_ship_to_zip, :x_email, :x_invoice_number, :credit_card_number,
                :ccv_number, :total_amount, :cc_expiry_month, :cc_expiry_year
  attr_accessible :first_name, :last_name, :credit_card_number, :address, :address2, :city, :state, :zip, :phone, :email,
                  :billing_address, :billing_address2, :billing_city, :billing_state, :billing_zip, 
                  :shipping_method_id, :invoice_number, :status, :account_id, :ccv_number, :total_amount,
                  :cc_expiry_month, :cc_expiry_year, :payment_total_cost, :shipping_cost, :tax
  
              
  has_many :line_items
  has_one :cart
  belongs_to :account  # optional linkage (an order can be done by a "guest" not signed in)
  belongs_to :shipping, :foreign_key => 'shipping_method_id'

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :phone, presence: true
  validates :email, presence: true
  validates :billing_address, presence: true
  validates :billing_city, presence: true
  validates :billing_state, presence: true
  validates :billing_zip, presence: true
  validates :credit_card_number, presence: true, numericality: true, length: {minimum: 15, maximum: 16}
  validates :cc_expiry_year, presence: true
  validates :cc_expiry_month, presence: true
  validates :ccv_number, presence: true, numericality: true, length: {minimum: 3, maximum: 4}
  
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
    self.save
  end
  
  # Validate the credit card fields (this is only called at certain points from the controller)
  #def validate_cc_fields!
    #NOTE: these errors don't show up if they are added to individual virtual fields, so I've added them to :base
  #  self.errors.add(:credit_card_number, "Credit card number is required." ) unless self.credit_card_number.present?
  #  self.errors.add(:ccv_number, "CCV number is required." ) unless self.ccv_number.present?
  #  self.errors.add(:cc_expiry_month, "Expiration month is required." ) unless self.cc_expiry_month.present?
  #  self.errors.add(:cc_expiry_year, "Experation year is required." ) unless self.cc_expiry_year.present?
  #end

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
  def associate_cart_line_items(the_cart)
    the_cart.line_items.each do |a_line_item|
      self.line_items << a_line_item  # LineItem row is saved, with our order_id
    end
    the_cart.order_id = self.id
    the_cart.save
    self.save
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
  
  # NOTE: This must remain in this format -- it's used in the payment_hander CC api
  # mmYYYY string (can also be mmYY string, but having a 4-digit year is better)
  def cc_expiry
    self.cc_expiry_month + self.cc_expiry_year
  end
  
  #---------------------------------------------------------------------------
  # Construct array of upcoming years, for use in the expiry year dropdown
  # e.g. returns:  [["2015", "2015"],["2016", "2016"],["2017", "2017"],["2018", "2018"],...]
  def self.years_for_expiry
    first_year_allowed = Time.now.to_date.year
    
    (first_year_allowed..(first_year_allowed + 10)).map{ |y| [y.to_s, y.to_s] }
  end
  #---------------------------------------------------------------------------
  
  #---------------------------------------------------------------------------
  # Hide some of the credit card numbers (all but first number and last 4 numbers),
  # replacing the digits with 'X'.
  def mostly_hidden_credit_card_number
    cc_number_hidden = self.credit_card_number.dup
    cc_length = cc_number_hidden.length
    (1..cc_length-5).each{|x_it| cc_number_hidden[x_it] = 'X'}

    cc_number_hidden
  end
  #---------------------------------------------------------------------------
  
  def getNetSuiteCustomer
    customer = NetSuite::Records::Customer.search({basic: [{ field: 'email', operator: 'contains', value: self.email.strip }, { field: 'firstName', operator: 'contains', value: self.first_name.strip }, { field: 'lastName', operator: 'contains', value: self.last_name.strip }]})
    if customer.results[0] != nil
      return customer.results[0].internal_id
    else
      return nil
    end
  end

  def self.total_tax(total,state)
    state_rate = StateTaxRate.find_by_state_acronym(state).try(:tax_rate)
    tax = total.to_f * (state_rate.to_f/100)
    tax.round(2)
  end

  def submitToNetSuite
    customer_id = self.getNetSuiteCustomer
    if customer_id == nil
      customer_id = self.newNetSuiteCustomer
    end
    shipping_method = Shipping.find(self.shipping_method_id)
    line_items = []
    self.line_items.each do |li|
      line_items.push({quantity: li.quantity, item: NetSuite::Records::RecordRef.new(internal_id: li.netsuite_id, type: 'inventoryItem')})
    end
    netsuite_sales_order = {entity: NetSuite::Records::RecordRef.new({ internal_id: customer_id, type: 'customer' }), partner: NetSuite::Records::RecordRef.new({ internal_id: 11673, type: 'partner' }), order_status: '_pendingApproval', other_ref_num: self.invoice_number, custom_field_list: { custom_field: { internal_id: "custbody7", value: "37891", type: "platformCore:StringCustomFieldRef" } }, other_ref_num: 12345, item_list: { item: line_items }, ship_method: NetSuite::Records::RecordRef.new({internal_id: shipping_method.netsuite_id})}
    if !session[:promo].blank?
      netsuite_sales_order[:promoCode] = NetSuite::Records::RecordRef.new({ internal_id: session[:promo] })
    end
    so = NetSuite::Records::SalesOrder.new(netsuite_sales_order)
    so.add
  end

  def newNetSuiteCustomer
    customer = NetSuite::Records::Customer.new(custom_field_list: { custom_field: [{ internal_id: "custentity4", value: self.email, type: "platformCore:StringCustomFieldRef" }, { internal_id: "custentity2", value: "23", type: "platformCore:StringCustomFieldRef" }] }, email: self.email.strip, phone: self.phone, category: NetSuite::Records::RecordRef.new({ internal_id: 11, type: 'customerCategory' }), partner: NetSuite::Records::RecordRef.new({ internal_id: 11673, type: 'partner' }), is_person: TRUE, first_name: self.first_name.strip, last_name: self.last_name.strip, addressbook_list: { addressbook: [{ default_shipping: TRUE, default_billing: FALSE, is_residential: TRUE, addressee: "#{self.first_name} #{self.last_name}", phone: self.phone, addr1: self.address, addr2: self.address2, city: self.city, state: self.state, zip: self.zip, country:"_unitedStates" }, { default_shipping: FALSE, default_billing: TRUE, is_residential: TRUE, addressee: "#{self.first_name} #{self.last_name}", phone: self.phone, addr1: self.billing_address, addr2: self.billing_address2, city: self.billing_city, state: self.billing_state, zip: self.billing_zip, country:"_unitedStates" }] }, parent: NetSuite::Records::RecordRef.new({ internal_id: 38043 }))
    customer.add
    customer.internal_id
  end

end
