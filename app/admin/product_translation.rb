ActiveAdmin.register ProductTranslation do
  form do |f|
    #column "Product" do |product|
    #  link_to product.name, admin_product_path(product)
    #end
    f.inputs "Product Translation" do
      f.input :sku
      f.input :description
      f.input :price
      f.input :quantity
      f.input :threshhold
      f.input :netsuite_id
    end
    # :product_translation_id do |product_translation|
    #  link_to "#{product_translation.sku} - #{product_translation.description}", admin_product_translation_path(product_translation)
    #end
    f.actions
  end
end
