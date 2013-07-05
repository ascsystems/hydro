class AddDisplayToOptions < ActiveRecord::Migration
  def change
    add_column :options, :dipsplay_data, :string
  end
end
