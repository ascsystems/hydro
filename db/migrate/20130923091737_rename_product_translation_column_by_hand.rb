class RenameProductTranslationColumnByHand < ActiveRecord::Migration
  def up
    rename_column :product_translations, :product_option_value_image_id, :product_image_id
  end

  def down
    rename_column :product_translations, :product_image_id, :product_option_value_image_id
  end
end
