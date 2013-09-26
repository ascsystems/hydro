class PagesController < ApplicationController
  # GET /pages
  # GET /pages.json

  caches_page :five_back, :hydro_flask_social, :hydro_flask_technology, :show

  def index
    @pages = Page.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end

  def five_back
    @page = Page.find_by_slug("5-back")
    @featured_charity = Charity.find_by_featured(1)
  end


  def hydro_flask_technology
    @page = Page.find_by_slug("hydro-flask-technology")
  end
  # GET /pages/1
  # GET /pages/1.json
  def show
    @page = Page.find(params[:id])
    render 'shared/404', :status => 404 if @page.nil?
  end

  def hydro_flask_social
    @page = Page.find_by_slug("hydro-flask-social")
    storify = Storify.new
    @articles = storify.getArticles
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    @page = Page.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.json
  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :no_content }
    end
  end
end
