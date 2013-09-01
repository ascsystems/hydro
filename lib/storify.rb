require "open-uri"

class Storify
  
  def token
  	return @token
  end

  def api_key
  	return @api_key
  end

  def initialize
  	@token = "a4bb73c6f32ddb87177e64ff468885bb"
  	@api_key = "5222d27e41ef44465515fab4"
  end

  def getArticles
  	url_text = open("http://api.storify.com/v1/stories/HydroFlask?api_key#{@api_key}").read()
  	articles = JSON.parse(url_text)
  	return articles['content']
  end

end