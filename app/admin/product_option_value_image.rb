ActiveAdmin.register ProductOptionValueImage do
  form do |f|
    f.inputs "Product Option Value Image" do
      f.input :product_image_id, as: :select, collection: ProductImage.all.map {|pi| [pi.name, pi.id]}, include_blank: false
      f.input :product_option_value_id, as: :select, collection: ProductOptionValue.all.map {|pov| [pov.option_value.name, pov.id]}, include_blank: false
    end
    f.actions
  end
end
