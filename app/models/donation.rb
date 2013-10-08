class Donation < ActiveRecord::Base
  attr_accessible :charity_id, :comments, :email, :flask_purchased, :name, :newsletter, :place_of_purchase, :serial_number

  validates :name, presence: true
  validates :serial_number, presence: true, length: { maximum: 10 }, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :charity_id, presence: true
  validate :check_email

  def check_email
  	if self.newsletter == 1 && self.email.blank?
  		errors.add(:email, " is required to join the newsletter.")
  	end
  end

end