class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.integer :product_id
      t.string :name
      t.integer :order_num

      t.timestamps
    end
  end
end
