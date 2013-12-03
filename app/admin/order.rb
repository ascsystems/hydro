ActiveAdmin.register Order do
	filter :email
	filter :first_name
	filter :last_name
	filter :address
	filter :city
	filter :state
	filter :zip
	filter :created_at
	filter :invoice_number
	filter :payment_total_cost
	filter :netsuite_status
end
