class CategoryProduct < ActiveRecord::Base
  attr_accessible :category_id, :order_number, :product_id

  belongs_to :category
  belongs_to :product

  validates :category_id, :product_id, :order_number, presence: true
  validates_uniqueness_of :product_id, scope: :category_id
end
