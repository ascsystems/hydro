class RemoveProductidFromOptions < ActiveRecord::Migration
  def up
    remove_column :options, :product_id
  end

  def down
    add_column :options, :product_id, :integer
  end
end
