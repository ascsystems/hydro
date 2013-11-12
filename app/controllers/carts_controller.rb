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
    if(!params[:promo_code].blank?)
      self.applyPromo(params[:promo_code])
    end
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
    rates = ship.getShippingRates(params[:shipping_zip], weight.to_f, current_cart.subtotal.to_f)
    render json: rates
  end

  def applyPromo(promo_code)
    if(session[:promo].blank?)
      promo = Promotion.new
      this_promo = promo.getPromo(promo_code.downcase)
      if this_promo.blank?
        flash.now[:error] = "Invalid Promo"
      else
        session[:promo] = this_promo.netsuite_id
        current_cart.line_items.each do |i|
          i.product_price = (i.product_price * ((100 - this_promo.amount) * 0.01)).round(2)
          i.product_subtotal = i.quantity * i.product_price
          i.save
        end
        current_cart.set_subtotal
        flash.now[:notice] = "Promo Accepted"
      end
    else
      flash.now[:notice] = "Your promo has already been applied"
    end
  end

  def update_shipping
    #cart = current_cart
    order = current_order
    session[:order][:shipping_method_id] = params[:id]
    session[:order][:shipping_cost] = params[:price]
    #cart.save!
    render json: ''
  end

  def apply_promo
    render json: ''
  end

  def update_quantity
    line_item = LineItem.find(params[:line_item_id])
    quantity = params[:quantity].to_i
    if quantity < 1
      quantity = 1
    end
    line_item.quantity = quantity
    line_item.product_subtotal = quantity * line_item.product_price
    line_item.save!
    cart = current_cart
    cart.set_subtotal
    cart_update = {total: cart.subtotal.to_f, quantity: line_item.quantity, item_total: line_item.product_subtotal}
    render json: cart_update
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
