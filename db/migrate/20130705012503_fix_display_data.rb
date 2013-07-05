class FixDisplayData < ActiveRecord::Migration
  def change
    rename_column :options, :dipsplay_data, :display_data
  end

end
