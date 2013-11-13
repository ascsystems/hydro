ActiveAdmin.register CategoryProduct do

  index do
   	column "Category" do |cat|
  		cat.category.name
  	end
  	column "Product" do |prod|
  		prod.product.name
  	end
  	column :order_number
  	column :updated_at
  	actions
  end

end