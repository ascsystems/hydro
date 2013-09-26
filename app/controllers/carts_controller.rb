class CartsController < ApplicationController
  # GET /carts
  # GET /carts.json
  #def index
  #  @carts = Cart.all
  #
  #  respond_to do |format|
  #    format.html # index.html.erb
  #    format.json { render json: @carts }
  #  end
  #end

  # /mycart ------------------------------------------------------------------
  # GET /carts/1
  # GET /carts/1.json
  def show
    # new cart is created, unless cart for this session or user already exists
    @cart = current_cart  # application_controller.rb method

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cart }
    end
  end
  #---------------------------------------------------------------------------
  
  def getShipping
    ship = Shipping.new
    weight = current_cart.line_items.map(&:weight).sum
    subtotal = current_cart.line_items.map(&:product_price).sum
    rates = ship.getShippingRates(params[:shipping_zip], weight, subtotal)
    render json: rates
  end

#FIXME: thse are all just left over from CRUD, right?
=begin
  # GET /carts/new
  # GET /carts/new.json
  def new
    @cart = Cart.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cart }
    end
  end

  # GET /carts/1/edit
  def edit
    @cart = Cart.find(params[:id])
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(params[:cart])

    respond_to do |format|
      if @cart.save
        format.html { redirect_to '/mycart', notice: 'Cart was successfully created.' }
        format.json { render json: @cart, status: :created, location: @cart }
      else
        format.html { render action: "new" }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /carts/1
  # PUT /carts/1.json
  def update
    @cart = Cart.find(params[:id])

    respond_to do |format|
      if @cart.update_attributes(params[:cart])
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy

    respond_to do |format|
      format.html { redirect_to carts_url }
      format.json { head :no_content }
    end
  end
  
=end
end
