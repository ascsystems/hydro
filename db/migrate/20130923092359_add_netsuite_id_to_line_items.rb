class AddNetsuiteIdToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :netsuite_id, :integer
  end
end
