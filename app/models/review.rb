class Review < ActiveRecord::Base
  attr_accessible :body, :name, :product_id, :rating, :title

  belongs_to :product

end