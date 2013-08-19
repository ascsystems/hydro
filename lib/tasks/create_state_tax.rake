namespace 'state' do
  desc 'Create default shippings'
  task :create_taxes => :environment  do
  	states = ['AK', 'AL', 'AR', 'AZ', 'CA', 'CO', 'CT', 'DC', 'DE', 'FL', 'GA', 'HI','IA', 'ID', 'IL', 'IN','KS', 'KY', 'LA', 'MA', 'MD', 'ME', 'MI', 'MN', 'MO', 'MS', 'MT', 'NC', 'ND', 'NE', 'NH', 'NJ','NM','NV','NY','OH', 'OK','OR','PA', 'RI','SC', 'SD','TN','TX','UT', 'VA', 'VT', 'WA', 'WI', 'WV', 'WY']
  	states.each {|s|
  		StateTaxRate.find_or_create_by_state_acronym(:state_acronym =>s, :tax_rate => 10)
  	}
  end
end

