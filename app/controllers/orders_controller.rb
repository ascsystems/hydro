class OrdersController < ApplicationController
  
  def show
    @order = Order.where("id = ? and account_id = ? ", params[:id], current_account.id).first
  end

  def new

    @order = Order.new(current_order)

    the_cart = current_cart
    if the_cart.line_items.empty?
      redirect_to '/mycart'
    end

    @order[:account_id] = current_account.id if current_account
  end


  def confirm
    
    if(!params[:order].blank?)
      session[:order].merge!(params[:order])
    elsif session[:order].blank?
      render :action => :new
      return
    end

    @order = Order.new(current_order)

    if current_account.blank? && params[:new_account_password].present? && params[:order][:email].present?
      if params[:new_account_password].length < 8
        @custom_error = "Your password must be at least 8 characters long."
        render :action => :new
        return
      end
      new_account = sign_in_user_and_associate_to_cart(current_cart, params[:order][:email], params[:new_account_password])
      unless new_account.valid?
        @custom_error = "Failed to create a new account."
        render :action => :new
        return
      end
    end
    
    if @order.valid?
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
      @selected_shipping_id = current_order[:shipping_method_id].to_i
    else
      render action: :new
    end
  end


  def payment
    
    @order = Order.new(current_order)
    
    @order.payment_total_cost = current_cart[:subtotal].to_f + current_order[:shipping_cost].to_f + current_order[:tax].to_f;
            
    if (@order.valid?)
      begin
        @response = @order.make_payment
        @order.status = Order::ORDER_COMPLETED
        @order.save!
        @order.associate_cart_line_items(current_cart)
        @order.submitToNetSuite(session)
        current_cart.destroy
      rescue Exception => e
        @custom_error = e
        #@custom_error = "Your credit card transaction was declined, please try again with another card."
        render action: :new
      end
    else
      render action: :new
    end
  end

end
