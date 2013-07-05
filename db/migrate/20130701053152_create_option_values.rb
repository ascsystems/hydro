class CreateOptionValues < ActiveRecord::Migration
  def change
    create_table :option_values do |t|
      t.integer :option_id
      t.string :name
      t.decimal :price
      t.integer :order_num

      t.timestamps
    end
  end
end
