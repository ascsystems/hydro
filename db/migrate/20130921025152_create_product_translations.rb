class CreateProductTranslations < ActiveRecord::Migration
  def change
    create_table :product_translations do |t|
      t.string :sku
      t.string :description
      t.decimal :price

      t.timestamps
    end
  end
end
