class AddMetaToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :title, :string
    add_column :categories, :meta_description, :string
    add_column :categories, :keywords, :string
  end
end
