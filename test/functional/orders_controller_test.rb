require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post :create, order: { address2: @order.address2, address: @order.address, billing_address2: @order.billing_address2, billing_address: @order.billing_address, billing_city: @order.billing_city, billing_state: @order.billing_state, billing_zip: @order.billing_zip, city: @order.city, email: @order.email, first_name: @order.first_name, last_name: @order.last_name, shipping_method_id: @order.shipping_method_id, state: @order.state, zip: @order.zip }
    end

    assert_redirected_to order_path(assigns(:order))
  end

  test "should show order" do
    get :show, id: @order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order
    assert_response :success
  end

  test "should update order" do
    put :update, id: @order, order: { address2: @order.address2, address: @order.address, billing_address2: @order.billing_address2, billing_address: @order.billing_address, billing_city: @order.billing_city, billing_state: @order.billing_state, billing_zip: @order.billing_zip, city: @order.city, email: @order.email, first_name: @order.first_name, last_name: @order.last_name, shipping_method_id: @order.shipping_method_id, state: @order.state, zip: @order.zip }
    assert_redirected_to order_path(assigns(:order))
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order
    end

    assert_redirected_to orders_path
  end
end
