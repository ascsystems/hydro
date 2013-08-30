class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @order = Order.new
    shipping = Shipping.find(params["sm"])
    @order.shipping_method_id = shipping.id

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end
  
  # FIXME: create a better flow for the order fulfillment (so going back from errors is handled properly)
  #---------------------------------------------------------------------------
  def initiate
    #@order = Order.new
    #shipping = Shipping.find(params["sm"])
    #@order.shipping_method_id = shipping.id

    #respond_to do |format|
    #  format.html # new.html.erb
    #  format.json { render json: @order }
    #end
  end
  #---------------------------------------------------------------------------
  
  #---------------------------------------------------------------------------
  # Order has just been submitted,
  def confirm
    
    #FIXME: to complete
    #order_attrs = params[:order]
    #
    #if params[:billing_same_as_shipping] == 1
    #  
    #end
    
    @order = Order.new(params[:order])  #.merge(order_attrs)
    unless @order.valid?
      render action: :new
    else
      # confirm.html.erb is rendered by default
    end
  end
  #---------------------------------------------------------------------------

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  #---------------------------------------------------------------------------
  # Save the Order to the DB, and process the CC transaction
  def payment
    @order = Order.new(params[:order])
    
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
end
