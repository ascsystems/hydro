require 'test_helper'

class ProductOptionValuesControllerTest < ActionController::TestCase
  setup do
    @product_option_value = product_option_values(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_option_values)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_option_value" do
    assert_difference('ProductOptionValue.count') do
      post :create, product_option_value: { option_value_id: @product_option_value.option_value_id, price: @product_option_value.price, product_id: @product_option_value.product_id }
    end

    assert_redirected_to product_option_value_path(assigns(:product_option_value))
  end

  test "should show product_option_value" do
    get :show, id: @product_option_value
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_option_value
    assert_response :success
  end

  test "should update product_option_value" do
    put :update, id: @product_option_value, product_option_value: { option_value_id: @product_option_value.option_value_id, price: @product_option_value.price, product_id: @product_option_value.product_id }
    assert_redirected_to product_option_value_path(assigns(:product_option_value))
  end

  test "should destroy product_option_value" do
    assert_difference('ProductOptionValue.count', -1) do
      delete :destroy, id: @product_option_value
    end

    assert_redirected_to product_option_values_path
  end
end
