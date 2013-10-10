class Search

  def getResults(query, search_order)
    if !query.blank?
     	query = Rack::Utils.escape(query)
        query.sub!('+','%7C')
        url = "http://search-hydrosearch-1-fpm4c3xnn5ya6gy2lbqctgpagm.us-west-2.cloudsearch.amazonaws.com/2011-02-01/search?q=#{query}&return-fields=author%2Cdescription%2Cid%2Ckeywords%2Cname%2Ctext_relevance"
        url_data = Net::HTTP.get(URI.parse(url))
        json_data = JSON.parse(url_data)
        product_ids = []
        json_data["hits"]["hit"].each do |j|
        	product_ids << j["data"]["id"]
        end
        if search_order.blank? or search_order == 'relevance'
            products = Product.find(product_ids, order: "field(id, #{product_ids.join(',')})")
        else
            products = Product.find(product_ids, order: search_order)
        end
    end
    return products
  end

end