# Perform the CC transaction (raises exception if not successful)
#
# NOTE: your server must be accessible from the internet in order for this to work,
#       and when in production mode, the server port must be 80 or 443  (can't run production mode with localhost:3000)
#
# See AIM description at: http://developer.authorize.net/integration/fifteenminutes/ruby/#custom
#
# See gem code info at: http://rubydoc.info/gems/authorize-net/1.5.2/AuthorizeNet/AIM/Transaction#initialize-instance_method
#
# FAQ info:  http://developer.authorize.net/testingfaqs/#connect
#
# Quickstart guide:  http://developer.authorize.net/integration/fifteenminutes/ruby/#custom
# Detailed AIM documentation:  http://developer.authorize.net/api/aim/
# AIM doc:  http://developer.authorize.net/guides/AIM/wwhelp/wwhimpl/js/html/wwhelp.htm

module PaymentHandler
	class Billing

    def initialize api_login_id, transaction_key, gateway
      @api_login_id = api_login_id
      @transaction_key = transaction_key
      @gateway = gateway.to_sym
		end

    def make_payment(order)
			
			# For test mode, send :test_mod => true in the same hash with the :gateway
      transaction = AuthorizeNet::AIM::Transaction.new( @api_login_id, @transaction_key,{:gateway => @gateway})
      #raise transaction.inspect
      
      #********************************************************
      # NOTE: These field names are prefixed with "x_" within the gem, so the names must
      #       correspond to the fields in the AIM spec:  http://developer.authorize.net/guides/AIM/wwhelp/wwhimpl/js/html/wwhelp.htm
      
      # FIXME:  do we need a different "name on card" field?
      transaction.set_fields(:email => order.email)  # was :email_address
      transaction.set_fields(:first_name => order.first_name)
      transaction.set_fields(:last_name => order.last_name)
      transaction.set_fields(:ship_to_first_name => order.first_name)
      transaction.set_fields(:ship_to_last_name => order.last_name)
      transaction.set_fields(:ship_to_address => order.address)
      transaction.set_fields(:ship_to_city => order.city)
      transaction.set_fields(:ship_to_state => order.state)
      transaction.set_fields(:ship_to_zip => order.zip)    # was :ship_to_zip_code
      transaction.set_fields(:address => order.billing_address)
      transaction.set_fields(:city => order.billing_city)
      transaction.set_fields(:state => order.billing_state)
      transaction.set_fields(:zip => order.billing_zip)  # was :zip_code
      transaction.set_fields(:tax => order.tax_amount)
      transaction.set_fields(:exp_date => order.cc_expiry)
      transaction.set_fields(:invoice_num => order.invoice_number)
      #TODO:  what about country?
      
      #TODO: do we need to add the line items?  (it's possible to do so, through the gem)
      #transaction.set_fields({:line_item => ["item1<|>golf balls<|><|>2<|>18.95<|>Y", "item2<|>golf bag<|>Wilson golf carry bag, red<|>1<|>39.99<|>"]})
      
      # for testing use CC number '4111111111111111', and card date (MMYY) '1122'
      # NOTE: cc_expiry can be MMYYYY format, which is what we're using.
      credit_card = AuthorizeNet::CreditCard.new(order.credit_card_number, order.cc_expiry, {:card_code => order.ccv_number})
      response = transaction.purchase(order.total_amount, credit_card)
      
      # Raise an error with some detailed error text if the CC transaction failed
      raise('Please verify your credit card information and try again.') if response.success? == false
      
      # Use this to show the exact error, for debugging only:
      # Note: to show the full response data, also add: + response.inspect
      #raise('Credit card authorization error: ' + response.response_reason_text.to_s + ' (Code: ' + response.response_reason_code + ')') if response.success? == false
      
      response
    end
	end
end

# example failure
#<AuthorizeNet::AIM::Transaction:0xb08d74c @fields={}, @custom_fields={}, @test_mode=false, @version="3.1", @api_login_id="5m7Y75eF9N", @api_transaction_key="5Vdd57sE9ncd56TE", @response=nil, @delimiter=",", @type="AUTH_CAPTURE", @cp_version=nil, @gateway="https://test.authorize.net/gateway/transact.dll", @allow_split_transaction=false, @encapsulation_character=nil, @verify_ssl=false, @market_type=2, @device_type=1>