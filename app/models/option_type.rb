class OptionType < ActiveRecord::Base
  attr_accessible :name

  belongs_to :product_type
  has_many :options

  validates :name, uniqueness: true, presence: true

end
