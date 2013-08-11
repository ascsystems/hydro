class AddMetaToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :title, :string
    add_column :brands, :meta_description, :string
    add_column :brands, :keywords, :string
  end
end
