class ProductsController < ApplicationController
  # GET /products
  # GET /products.json

  caches_page :show

#  def index
#    @products = Product.all
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.json #{ render json: @products }
#    end
#  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.friendly.find(params[:id])
    @product_image = @product.get_default_image
    if @product_image[0].product_translation.quantity.to_i - @product_image[0].product_translation.threshhold.to_i > 0
      @in_stock = true
    else
      @in_stock = false
    end
    # set review object, in case user uses the review form on the product page
    @new_review = Review.new
    
    # get sorted list of production reviews, to be displayed in the "Reviews" tab
    @product_reviews = @product.reviews.most_recent

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
#  def edit
#    @product = Product.find(params[:id])
#  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def netsuite_connect
    item = NetSuite::Records::BaseRefList.get_select_value(
      field: 'class',
      recordType: 'salesOrder',
      sublist: 'itemList'
    )
    render text: item.inspect
    #nets = Netsuite.new
    #render text: nets.initialize1
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
 # def destroy
 #   @product = Product.find(params[:id])
 #   @product.destroy
#
#    respond_to do |format|
#      format.html { redirect_to products_url }
#      format.json { head :no_content }
#    end
#  end
end
