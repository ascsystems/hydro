class Product < ActiveRecord::Base
  attr_accessible :description, :name, :price, :brand_id, :product_type_id, :short_name, :title, :meta_description, :keywords

  belongs_to :brand
  belongs_to :product_type
  has_many :category_products, dependent: :destroy
  has_many :categories, through: :category_products
  has_many :reviews
  has_many :line_items
  has_many :product_images
  has_many :product_option_values
  has_many :option_values, through: :product_option_values, order: "option_values.order_num"
  has_many :options, through: :option_values, order: "options.order_num", uniq: true
  has_many :related_products
  has_many :products, through: :related_products, source: :related_product
  has_one :product_image, conditions: {default_image: 1}

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :name, uniqueness: true, presence: true
  validates :short_name, uniqueness: true, presence: true
  validates :price, presence: true, numericality: true, format: { with: /^\d{1,4}(\.\d{0,2})?$/ }
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

  def related_products
    if self.related_products.empty?
      return Product.find(3,4,1,2)
    else
      return self.related_products
    end
  end

  def sorted_options
    options = self.option_values.group_by(&:option).to_a
    options.sort_by{|o| o[0][:order_num]}
  end

  def product_options_by_id(id)
    option_values.includes(option: :option_type).where("option_types.id = ?", id)
  end

  def product_colors
      self.product_options_by_id(1)
  end

  def product_lids
      self.product_options_by_id(2)
  end

  def product_accessories
      self.product_options_by_id(3)
  end

  def rating
    rating = reviews.average(:rating).to_f.round
  end
  
  # The products to feature, if no related products are found
  def self.default_featured_products
    featured_products = []
    # Special IDs (Need to be finalized on the production environment)
    [3, 4, 1, 2].each do |product_id|
      a_product = Product.find(product_id)
      featured_products << a_product
    end
    featured_products
  end

end
