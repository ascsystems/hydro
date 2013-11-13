ActiveAdmin.register ProductOptionValueImage do

  index do
  	column :id
  	column "Product Image" do |img|
  		img.product_image.name
  	end
    column "Product Option" do |pov|
  		"#{pov.product_option_value.product.name} - #{pov.product_option_value.option_value.name}"
  	end
  	column :updated_at
  	actions
  end

  form do |f|
    f.inputs "Product Option Value Image" do
      f.input :product_image_id, as: :select, collection: ProductImage.all.map {|pi| [pi.name, pi.id]}, include_blank: false
      f.input :product_option_value_id, as: :select, collection: ProductOptionValue.all.map {|pov| ["#{pov.product.name} - #{pov.option_value.name}", pov.id]}, include_blank: false
    end
  end
end
