require 'active_shipping'
include ActiveMerchant::Shipping
class Shipping < ActiveRecord::Base
  attr_accessible :display_text, :cost

  def getShippingRates(zip, weight, subtotal)
    #weight = current_cart.weight.sum
    if !defined? weight
      weight = 1
    end
		package = [Package.new(weight,[], cylinder: false)]
		origin = Location.new(country: 'US', state: 'OR', city: 'Portland', zip: '97230')
		destination = Location.new(zip: zip, country:'US')
		fedex = FedEx.new(login:'105709763', password:'CRk5Sbid93FAg1w3QoKQpZ0j6', account: '481980844', key: '8SNeVuvDbqN8KOGt', test: false)
    response = fedex.find_rates(origin, destination, package)
    rates = []
    shipping_types = Shipping.all
    standard_shipping = ShippingCostRate::find_best_shipping_cost('*', subtotal )
    rates.push({id: shipping_types[0][:id], name: shipping_types[0][:display_text], price: standard_shipping[:shipping_cost] })
  	response.rates.each do |rate|
      shipping_types.each do |type|
        if rate.service_name == type[:key_text]
  		    rates.push({id: type[:id], name: type[:display_text], price: (rate.total_price * 0.01)})
        end
      end
  	end
  	rates
  end

end