class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.json
  #def index
  #  @orders = Order.all
  #
  #  respond_to do |format|
  #    format.html # index.html.erb
  #    format.json { render json: @orders }
  #  end
  #end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  #---------------------------------------------------------------------------
  # This is called (via JS) after the user clicks "Continue to Checkout" in their cart (carts/show.html.erb)
  # GET /orders/new
  def new
    # if this is being rendered in a failure fallback case, then we use the
    # @order variable that is already filled with the information.
    @order = @order || Order.new
    
    # set the shipping method based on the value selected by the user in the cart view
    shipping = Shipping.find(params["sm"])
    @order.shipping_method_id = shipping.id
    
    # Set the user account (unless the user is not logged in - in which case the cart is anoymous)
    @order.account_id = current_account.id if current_account
    
    # also save shipping method to the cart, in case the order is stopped, and the user goes back to the cart
    the_cart = current_cart
    the_cart.shipping_method_id = shipping.id
    the_cart.save
    
    #renders new.html.erb
  end
  #---------------------------------------------------------------------------
  
  #---------------------------------------------------------------------------
  # Order has just been submitted,
  def confirm
    
    # if user has said their billing address is the same as their shipping address,
    # copy the shipping address params into the billing address params
    billing_params = {}
    if params[:billing_same_as_shipping] == '1'
      billing_params = Order::set_billing_same_as_shipping(params[:order])
    end
    all_params = billing_params.merge!(params[:order])
    @order = Order.new(all_params)
    unless @order.valid?
      render action: :new  # failure case; go back to new()
    else
      # confirm.html.erb is rendered
    end
  end
  #---------------------------------------------------------------------------

  # GET /orders/1/edit
  #def edit
  #  @order = Order.find(params[:id])
  #end

  #---------------------------------------------------------------------------
  # Save the Order to the DB, and process the CC transaction (this happens after confirm)
  def payment
    # rebuild the order (the order params are passed through in a hidden form on the confirm page)
    @order = Order.new(params[:order])
    
    # Associate the cart line items to this order
    @order.accociate_cart_line_items(current_cart)
    
    if @order.valid?
      begin
        @order.save!
        @response = @order.make_payment
        flash[:notice] = "Successfully made a purchase (authorization code: #{@response.authorization_code})"
        current_cart.destroy
        @order.status = Order::ORDER_COMPLETED
        @order.save!
      rescue Exception => e
        @order.errors.add(:base, e.message)  # e.backtrace.inspect to debug
        # go back to the order view, where they can edit fields and resubmit
        render action: :new  #TODO should we render "edit" here?
      end
    else
      # go back to the order view, where they can edit fields and resubmit
      # @order.errors should contain the associated errors, and will be shown in flash.
      render action: :new  
    end
  end
  #---------------------------------------------------------------------------
  
  # The normal update method does not work for our funny different stages, during error case
  #def update
  #  @order = Order.find(params[:order])
  #  
  #  if @order.update_attributes(params[:order])
  #    render action: 'confirm'
  #  else
  #    render action: 'edit'
  #  end
  #  
  #end

#FIXME: this was original CRUD, right? These actions should not be permitted.
=begin
  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(params[:order])

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # This is used in the error case
  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end
=end

end
