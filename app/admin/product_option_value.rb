ActiveAdmin.register ProductOptionValue do

  index do
  	column :id
  	column "Product" do |prod|
  		prod.product.name
  	end
    column "Option" do |opt|
  		opt.option_value.name
  	end
  	column :price
  	column :order_num
  	column :updated_at
  	actions
  end

end