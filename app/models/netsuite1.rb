# Changed from "class" to "module" because it blew up when in production mode
module Netsuite

  def initialize1
    client = Savon.client(wsdl: 'https://webservices.netsuite.com/wsdl/v2_5_0/netsuite.wsdl', namespace: 'urn:core_2_5.platform.webservices.netsuite.com')
	#client.operations
	response = client.call(:login, message: { passport: { email: "davids@officedesigns.com", password: "Gr3ys34l!", account: 1273675 } } )
	response.inspect
	#client.operations
	#if response.success? == false
	#  puts "login failed"
	#  System.exit(0)
	#end
  end

end
