module PaymentHandler
	class Billing

    def initialize api_login_id, transaction_key, gateway
      @api_login_id = api_login_id
      @transaction_key = transaction_key
      @gateway = gateway.to_sym
		end

    def make_payment(order)
      transaction = AuthorizeNet::AIM::Transaction.new( @api_login_id, @transaction_key,{:gateway =>@gateway})
      transaction.set_fields(:exp_date => order.exp_date)
      transaction.set_fields(:email_address => order.email)
      transaction.set_fields(:first_name => order.first_name)
      transaction.set_fields(:last_name => order.last_name)
      response = transaction.purchase(order.total_amount, order.credit_card_number, options = {})
      raise "DuplicatePaymentError" if response.success? ==false
      response
    end
	end
end