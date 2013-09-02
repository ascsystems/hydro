class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :items_in_cart,  :current_cart, :header_categories, :authorize_net

  private

  #---------------------------------------------------------------------------
  # Get the user's current cart (will auto-create blank one if none exists)
  def current_cart
    # current web session has a cart, so just return it
    cart = Cart.find_by_id(session[:cart_id])
    return cart if cart
    
    # if the cart has not been defined in the session, see if the logged-in user
    # had a cart in progress from their last visit to the site.
    cart = Cart.find_by_account_id(current_account.id) if (current_account && !cart)
    
    # No cart found in session of for user account, then create new one
    cart = Cart.create unless cart
    # Save user account against the cart, if the user is logged in
    cart.account_id = current_account.id if current_account
    
    # Save cart in the session
    session[:cart_id] = cart.id
    
    cart
  end
  #---------------------------------------------------------------------------

  def items_in_cart
    # protect from nil current_cart, although it should never happen
    current_cart ? current_cart.line_items.count : 0
  end

  def header_categories
    Category.find(:all)
  end

  after_filter :store_location

  def store_location
   # store last url - this is needed for post-login redirect to whatever the user last visited.
      if (request.fullpath != "/accounts/sign_in" && \
          request.fullpath != "/accounts/sign_up" && \
          request.fullpath != "/accounts/password" && \
          !request.xhr?) # don't store ajax calls
        session[:previous_url] = request.fullpath
      end
  end

  # redirect to the page the user was on before sign-in, or if they were on the main sign-in view, redirect to root
  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  def after_sign_out_path_for(resource)
    session[:previous_url] || root_path
  end

  def redirect_url
    session[:previous_url] || login_path
    flash[:notice] = "Invalid login or password"
  end
end