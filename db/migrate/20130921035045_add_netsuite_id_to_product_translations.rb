class AddNetsuiteIdToProductTranslations < ActiveRecord::Migration
  def change
    add_column :product_translations, :netsuite_id, :int
  end
end
