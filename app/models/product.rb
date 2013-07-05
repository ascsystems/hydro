class Product < ActiveRecord::Base
  attr_accessible :description, :name, :price

  belongs_to :brand
  belongs_to :product_type
  has_many :category_products, dependent: :destroy
  has_many :categories, through: :category_products
  has_many :line_items
  has_many :product_images
  has_many :product_option_values

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :name, uniqueness: true, presence: true
  validates :price, presence: true
  validates :brand_id, presence: true
  validates :product_type_id, presence: true

  def ensure_not_referenced_by_any_line_item
    if line_items.count.zero?
      return true
    else
      errors.add(:base, 'Line Items Exist')
      return false
    end
  end

end
