namespace 'shippings' do
  desc 'Create default shippings'
  task :create => :environment  do
  	shipping_methods = ['Standard - FREE','2nd Day - $20.00','Overnight - $50.00']
  	shipping_methods.each { |name|
	    Shipping.find_or_create_by_display_text(display_text:name)
	}
  end
end

