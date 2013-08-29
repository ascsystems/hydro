class EmailSubscription < ActiveRecord::Base

  attr_accessible :email_address

  belongs_to :user  # optional

  validates :email_address, presence: true
  
end