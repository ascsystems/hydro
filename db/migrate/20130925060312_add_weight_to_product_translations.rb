class AddWeightToProductTranslations < ActiveRecord::Migration
  def change
    add_column :product_translations, :weight, :integer
  end
end
