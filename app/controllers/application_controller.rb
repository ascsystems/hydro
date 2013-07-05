class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :items_in_cart

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

end
