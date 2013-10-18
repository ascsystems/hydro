class SocialsController < ApplicationController

	def index
    @social = Social.new
	  @articles = Social.all.order("active_date desc")
	end

	def update_social
	  storify = Storify.new
	  tmp_articles = storify.getArticles
	  articles = []
	  tmp_articles['stories'].each do |a|
	    articles.push(storify.getArticle(a['slug']))
	  end
	  articles.each do |a|
	  	if a['meta']['quoted'][0]['avatar'].blank?
	  		avatar = ''
	  	else
	  		avatar = a['meta']['quoted'][0]['avatar']
	  	end
	  	if a['thumbnail'] != "http://storify.com/public/img/default-thumb.gif"
	  		thumbnail = a['thumbnail']
	  	else
	  	  thumbnail = ''
	  	end
			if a['elements'][0]['data']['quote'].blank?
				quote = ''
			else
				quote = a['elements'][0]['data']['quote']['text']
			end
			if a['elements'][0]['data']['video'].blank?
				video = ''
			else
				video = a['elements'][0]['data']['video']['title']
			end
			if a['elements'][0]['data']['image'].blank?
				image_caption = ''
			else
				image_caption = a['elements'][0]['data']['image']['caption']
			end
	  	new_a = Social.new({ slug: a['slug'], permalink: a['elements'][0]['permalink'], avatar: avatar, article_date: a['date']['published'], active_date: a['date']['published'], title: a['title'], author: a['meta']['quoted'][0]['name'], thumbnail: thumbnail, shortlink: a['shortlink'], description: a["description"], quote: quote, video: video, image_caption: image_caption })
	  	new_a.save
	  end
	  render json: ""
	end

end