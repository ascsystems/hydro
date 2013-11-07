ActiveAdmin.register ProductImage do
  form do |f|
    #column "Product" do |product|
    #  link_to product.name, admin_product_path(product)
    #end
    f.inputs "Product Image" do
      f.input :product_id, as: :select, collection: Product.all.map {|p| [p.name, p.id]}, include_blank: false
      f.input :path
      f.input :name
      f.input :default_image
      f.input :product_translation_id, as: :select, collection: ProductTranslation.all.map {|pt| ["#{pt.sku} - #{pt.description}", pt.id]}, include_blank: false
    end
    # :product_translation_id do |product_translation|
    #  link_to "#{product_translation.sku} - #{product_translation.description}", admin_product_translation_path(product_translation)
    #end
    f.actions
  end
end
