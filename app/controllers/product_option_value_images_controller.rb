class ProductOptionValueImagesController < ApplicationController
  # GET /product_option_value_images
  # GET /product_option_value_images.json
  def index
    @product_option_value_images = ProductOptionValueImage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @product_option_value_images }
    end
  end

  # GET /product_option_value_images/1
  # GET /product_option_value_images/1.json
  def show
    @product_option_value_image = ProductOptionValueImage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product_option_value_image }
    end
  end

  # GET /product_option_value_images/new
  # GET /product_option_value_images/new.json
  def new
    @product_option_value_image = ProductOptionValueImage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product_option_value_image }
    end
  end

  # GET /product_option_value_images/1/edit
  def edit
    @product_option_value_image = ProductOptionValueImage.find(params[:id])
  end

  # POST /product_option_value_images
  # POST /product_option_value_images.json
  def create
    @product_option_value_image = ProductOptionValueImage.new(params[:product_option_value_image])

    respond_to do |format|
      if @product_option_value_image.save
        format.html { redirect_to @product_option_value_image, notice: 'Product option value image was successfully created.' }
        format.json { render json: @product_option_value_image, status: :created, location: @product_option_value_image }
      else
        format.html { render action: "new" }
        format.json { render json: @product_option_value_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /product_option_value_images/1
  # PUT /product_option_value_images/1.json
  def update
    @product_option_value_image = ProductOptionValueImage.find(params[:id])

    respond_to do |format|
      if @product_option_value_image.update_attributes(params[:product_option_value_image])
        format.html { redirect_to @product_option_value_image, notice: 'Product option value image was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product_option_value_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_option_value_images/1
  # DELETE /product_option_value_images/1.json
  def destroy
    @product_option_value_image = ProductOptionValueImage.find(params[:id])
    @product_option_value_image.destroy

    respond_to do |format|
      format.html { redirect_to product_option_value_images_url }
      format.json { head :no_content }
    end
  end
end
