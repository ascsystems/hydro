namespace 'shippings' do
  desc 'Create default shippings'
  task :create => :environment  do
	Shipping.find_or_create_by_display_text(display_text:"Standard - FREE",  :cost => 0)
	Shipping.find_or_create_by_display_text(display_text:"2nd Day - $20.00",:cost =>20.00 )
	Shipping.find_or_create_by_display_text(display_text:"Overnight - $50.00",:cost => 50.00)
  end
end

