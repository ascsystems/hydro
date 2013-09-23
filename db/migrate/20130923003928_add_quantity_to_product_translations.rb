class AddQuantityToProductTranslations < ActiveRecord::Migration
  def change
    add_column :product_translations, :quantity, :int
  end
end
