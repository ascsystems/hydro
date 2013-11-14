class ProductTranslation < ActiveRecord::Base
  attr_accessible :description, :price, :sku, :netsuite_id, :quantity, :weight, :threshhold

  has_many :product_images

  def self.update_netsuite
    translations = ProductTranslation.all()
    translations.each do |t|
      item = NetSuite::Records::InventoryItem.get(t.netsuite_id)
      t.weight = item.weight.to_f
      item.pricing_matrix.prices.each do |i|
        if i.price_level[:name] == 'Web'
          t.price = i.price_list[:price][:value].to_f
          pi = ProductImage.where(product_translation_id: t.id).first
          if !pi.blank?
            pi.product.price = i.price_list[:price][:value].to_f
            pi.save
          end
        end
      end
      item_sum = 0
      item.locations_list.locations.each do |l|
        if l.location_id.internal_id.to_i == 2
          item_sum = item_sum + l.quantity_available.to_i
        end
      end
      t.quantity = item_sum
      t.save!
    end
  end

end
