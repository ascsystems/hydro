class Donation < ActiveRecord::Base
  attr_accessible :charity_id, :comments, :email, :flask_purchased, :name, :newsletter, :place_of_purchase, :serial_number
end
