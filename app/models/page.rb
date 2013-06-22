class Page < ActiveRecord::Base
  extend FriendlyId
  attr_accessible :title, :body
  validates_presence_of :title, :body

  friendly_id :title, use: :slugged
end
