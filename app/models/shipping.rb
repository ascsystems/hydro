require 'active_shipping'
include ActiveMerchant::Shipping
class Shipping < ActiveRecord::Base
  attr_accessible :display_text, :cost

  def getShippingRates(zip, weight)
    #weight = current_cart.weight.sum
    if !defined? weight
      weight = 1
    end
		package = [Package.new(weight,[], cylinder: false)]
		origin = Location.new(country: 'US', state: 'OR', city: 'Portland', zip: '97230')
		destination = Location.new(zip: zip, country:'US')
		fedex = FedEx.new(login:'100152071', password:'6KS4ljy8gONQ7D8FmqPSmaLyl', account: '510087607', key: 'nEDHoSL6I2XafWXv', test: true)
  	response = fedex.find_rates(origin, destination, package)
    rates = []
  	response.rates.each do |rate|
  		rates.push({name: rate.service_name, price: rate.total_price})
  	end
  	rates
  end

end