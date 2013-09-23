class AddProductTranslationIdToProductImages < ActiveRecord::Migration
  def change
    add_column :product_images, :product_translation_id, :integer
  end
end
