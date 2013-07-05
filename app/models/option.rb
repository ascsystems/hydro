class Option < ActiveRecord::Base
  attr_accessible :name, :order_num, :option_type_id

  belongs_to :option_type
  has_many :option_values

  validates :name, uniqueness: true, presence: true
  validates :option_type_id, presence: true
  validates :order_num, presence: true

end
