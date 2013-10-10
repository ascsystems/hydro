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
  #def show
  #  @order = Order.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.json { render json: @order }
#    end
#  end

  #---------------------------------------------------------------------------
  # This is called (via JS) after the user clicks "Continue to Checkout" in their cart (carts/show.html.erb)
  # GET /orders/new
  # Possible parameters:  'sm', and 'the_order_id'
  def new
    # if this is being rendered in a failure fallback case, then we use the
    # order that is specified as a parameter
    #@order = Order.find_by_id(params['the_order_id']) if params['the_order_id']
    @order = Order.new(current_order)

    # if an order was specified in the params (either an order re-do from failure case, or hacked params)
    #if @order
      # if this order was made by a user, but not this logged in user, or if the order set in the params
      # is already at a COMPLETED state, don't allow that order to be used; just create a new one
    #  if (@order.account && (@order.account != current_account)) || (@order.status == Order::ORDER_COMPLETED)
        #flash[:notice] = "The order you requested is not owned by you, or has already been completed.  A fresh order will be created."
    #    @order = Order.new
    #  end
    #else
    #  @order = Order.new  # fresh order
    #end
    
    the_cart = current_cart
    if the_cart.line_items.empty?
      redirect_to '/mycart'
    end
    # set the shipping method based on the value selected by the user in the cart view
    #if(!params["sm"].blank?)
    #  shipping = Shipping.find(params["sm"])
    #  @order.shipping_method_id = shipping.id
    #  the_cart.shipping_method_id = shipping.id
    #end
    # Set the user account (unless the user is not logged in - in which case the cart is anoymous)
    @order[:account_id] = current_account.id if current_account
    
    # also save shipping method to the cart, in case the order is stopped, and the user goes back to the cart
    #the_cart.save
    #renders new.html.erb
  end
  #---------------------------------------------------------------------------
  
  #---------------------------------------------------------------------------
  # Order has just been submitted (or re-submitted)
  def confirm
    
    #billing_params = {}
    #if params[:billing_same_as_shipping] == '1'
    #  billing_params = Order::set_billing_same_as_shipping(params[:order])
    #end
    #all_params = billing_params.merge!(params[:order])
    #@order = Order.new(all_params)
    if(!params[:order].blank?)
      session[:order] = params[:order]
    elsif session[:order].blank?
      render :action => :new
    end
    @order = Order.new(current_order)
    # First check to see if the user is creating a new account within the order form
    # (if the user is not logged in, and they are passing the account password parameter)
    if current_account.blank? && params[:new_account_password].present? && params[:order][:email].present?
      if params[:new_account_password].length < 8
        @custom_error = "Your password must be at least 8 characters long."
        #flash[:notice] = "Your password must be at least 8 characters long."
        render :action => :new
        return
      end
      new_account = sign_in_user_and_associate_to_cart(current_cart, params[:order][:email], params[:new_account_password])
      unless new_account.valid?
        @custom_error = "Failed to create a new account."
        #@order[:errors].push("Failed to create new account.")
        #flash[:notice] = "Failed to create new account with provided email and password. Please try again, or leave password blank to submit your order without an account."
        render :action => :new
        return
      end
    end
    
    # if user has said their billing address is the same as their shipping address,
    # copy the shipping address params into the billing address params

    
    # create the order based on the supplied parameters plus modified parameters
    @order.validate_cc_fields!  # check that CC info is present too
    
    if @order.valid?
      # **MUST** be called after .valid? !  (because .valid? clears all errors)
      @order.validate_cc_fields!  
      if @order.errors.any?
        render action: :new  # failure case; go back to new()
      else
        @tax = Order::total_tax(current_cart.subtotal, @order.state)
        session[:order][:tax] = @tax.to_f
        ship = Shipping.new
        weight = current_cart.line_items.map(&:weight).sum
        @shipping_options = ship.getShippingRates(@order.zip, weight, current_cart.subtotal.to_f)
        if current_order[:shipping_method_id].blank?
          session[:order][:shipping_method_id] = @shipping_options[0][:id]
          session[:order][:shipping_cost] = @shipping_options[0][:price]
        else
          @shipping_options.each do |s|
            if s[:id] == session[:order][:shipping_method_id]
              session[:order][:shipping_cost] = s[:price]
            end
          end
        end
        # confirm.html.erb is rendered
      end
    else
      render action: :new  # failure case; go back to new()
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
    #FIXME:
    # (or get existing order, if this one was created during a previous failed payment)
    #@order = Order.find_by_id(params[:order])
    @order = Order.new(current_order)
    
    # Associate the cart line items to this order
    @order.associate_cart_line_items(current_cart)
    
    # Set the total cost of the payment in the DB
    # (total_amount virtual field now contains the full calculated cost)
    @order.payment_total_cost = current_cart[:subtotal].to_f + current_order[:shipping_cost].to_f + current_order[:tax].to_f;
    
    is_valid_order = @order.valid?
    
    # Double-check that the CC info has been passed along to this point
    # **MUST** be called after .valid? !  (because .valid? clears all errors)
    @order.validate_cc_fields!
    
    is_valid_order = !(@order.errors.any?) && is_valid_order
    
    if (is_valid_order == true)
      begin
        #@response = @order.make_payment
        #flash[:notice] = "Successfully made a purchase (authorization code: #{@response.authorization_code})"
        current_cart.destroy
        @order.status = Order::ORDER_COMPLETED
        #@order.save!
        #Pass order info over to netsuite!
        @order.netsuite_id = @order.submitToNetSuite
        @order.save!
       #FIXME:  change to detect PaymentHandler Exception type only
      rescue Exception => e
        @order.status = Order::ORDER_FAILED
        @order.save!
        
        # Save to a special flash category, so we can check on the view and display the error fully
        #flash[:payment_failure] = e.message
        #@order.errors.add(:base, e.message)  # e.backtrace.inspect to debug
        
        # go back to the order view, where they can edit fields and resubmit
        
        #redirect_to new_order_path(:the_order_id => @order.id)
        
        # Not doing this anymore (a seperate failure view)
        #render :payment_failed
      end
    else
      # not doing this anymore (something messes up)
      render action: :new
      #render :payment_failed
    end
    
    # payment.html.erb is rendered in the success case
  end
  #---------------------------------------------------------------------------
  
  
  
  # The normal update method does not work for our funny different stages, during error case
  #def update
  #  @order = Order.find(params[:order])
  #  
  #  if @order.update_attributes(params[:order])
  #    render action: 'confirm'
  #  else
  #    render action: 'new'
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
