class AddColumnsToPages < ActiveRecord::Migration
  def change
    add_column :pages, :header_content, :text
    add_column :pages, :right_content, :text
  end
end
