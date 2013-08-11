class CreateLineItemOptions < ActiveRecord::Migration
  def change
    create_table :line_item_options do |t|
      t.integer :line_item_id
      t.integer :option_id
      t.string :option_name

      t.timestamps
    end
  end
end
