class Category < ActiveRecord::Base
  attr_accessible :description, :name, :title, :meta_description, :keywords

  has_many :category_products, dependent: :destroy
  has_many :products, through: :category_products, order: "category_products.order_number"

  validates :name, presence: true, uniqueness: true
end
