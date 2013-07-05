class CreateProductOptionValues < ActiveRecord::Migration
  def change
    create_table :product_option_values do |t|
      t.integer :option_value_id
      t.integer :product_id
      t.decimal :price

      t.timestamps
    end
  end
end
