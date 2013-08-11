class ProductType < ActiveRecord::Base
  attr_accessible :name

  has_many :products
  has_many :options

  validates :name, uniqueness: true, presence: true

end
