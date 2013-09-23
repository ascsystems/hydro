class AddProductOptionValueImageIdToProductTranslations < ActiveRecord::Migration
  def change
    add_column :product_translations, :product_option_value_image_id, :integer
  end
end
