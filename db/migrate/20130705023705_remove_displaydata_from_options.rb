class RemoveDisplaydataFromOptions < ActiveRecord::Migration
  def up
    remove_column :options, :display_data
  end

  def down
    add_column :options, :display_data, :string
  end
end
