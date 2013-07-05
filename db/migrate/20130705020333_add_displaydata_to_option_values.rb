class AddDisplaydataToOptionValues < ActiveRecord::Migration
  def change
    add_column :option_values, :display_data, :string
  end
end
