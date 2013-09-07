class EmailSubscription < ActiveRecord::Base

  attr_accessible :email_address

  #FIXME: this needs to be "account"
  #belongs_to :user  # optional

  validates :email_address, presence: true
  
end