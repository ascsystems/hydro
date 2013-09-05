class Store < ActiveRecord::Base
  attr_accessible :address1, :address2, :city, :country, :lat, :lng, :name, :phone, :state, :zip
end
