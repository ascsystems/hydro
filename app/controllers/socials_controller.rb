class SocialsController < ApplicationController

	def index
    @social = Social.new
	  @articles = Social.all.order("active_date desc")
	end

end