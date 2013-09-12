class SearchController < ApplicationController
  # GET /stores
  # GET /stores.json
  def index
    search = Search.new
    @search_results = search.getResults(params[:query], params[:search_order])
    @query = params[:query]
    @search_order = params[:search_order]
    respond_to do |format|
      format.html # index.html.erb
    end
  end


end