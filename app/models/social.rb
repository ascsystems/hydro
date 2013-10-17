class Social < ActiveRecord::Base
	 attr_accessible :slug, :permalink, :avatar, :article_date, :active_date, :title, :author, :thumbnail, :shortlink, :description, :quote, :video, :image_caption
end