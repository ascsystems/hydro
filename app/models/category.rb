class Category < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :category_products
  has_many :products, through: :category_products

  validates :name, presence: true, uniqueness: true
end
