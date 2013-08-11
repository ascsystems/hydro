class Order < ActiveRecord::Base
  attr_accessible :address, :address2, :billing_address, :billing_address2, :billing_city, :billing_state, :billing_zip, :city, :email, :first_name, :last_name, :shipping_method_id, :state, :zip

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

end
