class ProductTranslationsController < ApplicationController
  # GET /product_translations
  # GET /product_translations.json
  def index
    @product_translations = ProductTranslation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @product_translations }
    end
  end

  # GET /product_translations/1
  # GET /product_translations/1.json
  def show
    @product_translation = ProductTranslation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product_translation }
    end
  end

  # GET /product_translations/new
  # GET /product_translations/new.json
  def new
    @product_translation = ProductTranslation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product_translation }
    end
  end

  # GET /product_translations/1/edit
  def edit
    @product_translation = ProductTranslation.find(params[:id])
  end

  # POST /product_translations
  # POST /product_translations.json
  def create
    @product_translation = ProductTranslation.new(params[:product_translation])

    respond_to do |format|
      if @product_translation.save
        format.html { redirect_to @product_translation, notice: 'Product translation was successfully created.' }
        format.json { render json: @product_translation, status: :created, location: @product_translation }
      else
        format.html { render action: "new" }
        format.json { render json: @product_translation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /product_translations/1
  # PUT /product_translations/1.json
  def update
    @product_translation = ProductTranslation.find(params[:id])

    respond_to do |format|
      if @product_translation.update_attributes(params[:product_translation])
        format.html { redirect_to @product_translation, notice: 'Product translation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product_translation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_translations/1
  # DELETE /product_translations/1.json
  def destroy
    @product_translation = ProductTranslation.find(params[:id])
    @product_translation.destroy

    respond_to do |format|
      format.html { redirect_to product_translations_url }
      format.json { head :no_content }
    end
  end
end
