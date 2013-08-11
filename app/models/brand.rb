class Brand < ActiveRecord::Base
  attr_accessible :name, :title, :meta_description, :keywords

  has_many :products

  validates :name, uniqueness: true, presence: true

end
