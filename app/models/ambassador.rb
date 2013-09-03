class Ambassador < ActiveRecord::Base
  attr_accessible :bio, :discipline, :image_path, :first_name, :last_name
end
