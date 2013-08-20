class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :items_in_cart,  :current_cart, :header_categories, :authorize_net

  private

  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

  def items_in_cart
    current_cart.line_items.count
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