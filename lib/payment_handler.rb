# Perform the CC transaction (raises exception if not successful)
module PaymentHandler
	class Billing

    def initialize api_login_id, transaction_key, gateway
      @api_login_id = api_login_id
      @transaction_key = transaction_key
      @gateway = gateway.to_sym
		end

    def make_payment(order)
			
      transaction = AuthorizeNet::AIM::Transaction.new( @api_login_id, @transaction_key,{:gateway => @gateway})
      raise transaction.inspect
      transaction.set_fields(:email_address => order.email)
      transaction.set_fields(:first_name => order.first_name)
      transaction.set_fields(:last_name => order.last_name)
      transaction.set_fields(:ship_to_first_name => order.first_name)
      transaction.set_fields(:ship_to_last_name => order.last_name)
      transaction.set_fields(:ship_to_address => order.address)
      transaction.set_fields(:ship_to_city => order.city)
      transaction.set_fields(:ship_to_state => order.state)
      transaction.set_fields(:ship_to_zip_code => order.zip)
      transaction.set_fields(:address => order.billing_address)
      transaction.set_fields(:city => order.billing_city)
      transaction.set_fields(:state => order.billing_state)
      transaction.set_fields(:zip_code => order.billing_zip)
      transaction.set_fields(:tax => order.tax_amount)
      transaction.set_fields(:exp_date => order.exp_date)
      
      # order.ccv_number is not used ???!!
      
      # for testing use CC number '4111111111111111', and card date (MMYY) '1144'
      credit_card = AuthorizeNet::CreditCard.new(order.credit_card_number, order.exp_date)
      response = transaction.purchase(order.total_amount, credit_card)
      raise response.response_reason_text.to_s if response.success? ==false
      response
    end
	end
end