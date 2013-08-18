class CartRelatedProductsController < ApplicationController
  # GET /cart_related_products
  # GET /cart_related_products.json
  def index
    @cart_related_products = CartRelatedProduct.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cart_related_products }
    end
  end

  # GET /cart_related_products/1
  # GET /cart_related_products/1.json
  def show
    @cart_related_product = CartRelatedProduct.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cart_related_product }
    end
  end

  # GET /cart_related_products/new
  # GET /cart_related_products/new.json
  def new
    @cart_related_product = CartRelatedProduct.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cart_related_product }
    end
  end

  # GET /cart_related_products/1/edit
  def edit
    @cart_related_product = CartRelatedProduct.find(params[:id])
  end

  # POST /cart_related_products
  # POST /cart_related_products.json
  def create
    @cart_related_product = CartRelatedProduct.new(params[:cart_related_product])

    respond_to do |format|
      if @cart_related_product.save
        format.html { redirect_to @cart_related_product, notice: 'Cart related product was successfully created.' }
        format.json { render json: @cart_related_product, status: :created, location: @cart_related_product }
      else
        format.html { render action: "new" }
        format.json { render json: @cart_related_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cart_related_products/1
  # PUT /cart_related_products/1.json
  def update
    @cart_related_product = CartRelatedProduct.find(params[:id])

    respond_to do |format|
      if @cart_related_product.update_attributes(params[:cart_related_product])
        format.html { redirect_to @cart_related_product, notice: 'Cart related product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cart_related_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cart_related_products/1
  # DELETE /cart_related_products/1.json
  def destroy
    @cart_related_product = CartRelatedProduct.find(params[:id])
    @cart_related_product.destroy

    respond_to do |format|
      format.html { redirect_to cart_related_products_url }
      format.json { head :no_content }
    end
  end
end
