class Store < ActiveRecord::Base
  attr_accessible :address1, :address2, :city, :country, :lat, :lng, :name, :phone, :state, :zip

  def getStores(coords)
  	stores = Store.select("id, name, address1, address2, city, state, zip, country, lat, lng, ( 3959 * acos( cos( radians(#{coords["lat"]}) ) * cos( radians( lat ) ) * cos( radians( lng ) - radians(#{coords["lng"]}) ) + sin( radians(#{coords["lat"]}) ) * sin( radians( lat ) ) ) ) AS distance").order("distance asc").limit(4)
  end

  def getCoords(address)
 		address = Rack::Utils.escape(address)
    url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{address}&sensor=false"
    url_data = Net::HTTP.get(URI.parse(url))
    json_data = JSON.parse(url_data)
    if !json_data["results"].nil? && !json_data["results"].empty?
    	return json_data["results"][0]["geometry"]["location"]
    end
 	end

end