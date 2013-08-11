class AddMetaToProducts < ActiveRecord::Migration
  def change
    add_column :products, :short_name, :string
    add_column :products, :title, :string
    add_column :products, :meta_description, :string
    add_column :products, :keywords, :string
  end
end
