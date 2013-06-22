class Product < ActiveRecord::Base
  attr_accessible :description, :name, :price

  has_many :category_products
  has_many :categories, through: :category_products

  validates :name, uniqueness: true, presence: true
end
