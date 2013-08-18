require 'test_helper'

class CartRelatedProductsControllerTest < ActionController::TestCase
  setup do
    @cart_related_product = cart_related_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cart_related_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cart_related_product" do
    assert_difference('CartRelatedProduct.count') do
      post :create, cart_related_product: { product_id: @cart_related_product.product_id, related_product_id: @cart_related_product.related_product_id }
    end

    assert_redirected_to cart_related_product_path(assigns(:cart_related_product))
  end

  test "should show cart_related_product" do
    get :show, id: @cart_related_product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cart_related_product
    assert_response :success
  end

  test "should update cart_related_product" do
    put :update, id: @cart_related_product, cart_related_product: { product_id: @cart_related_product.product_id, related_product_id: @cart_related_product.related_product_id }
    assert_redirected_to cart_related_product_path(assigns(:cart_related_product))
  end

  test "should destroy cart_related_product" do
    assert_difference('CartRelatedProduct.count', -1) do
      delete :destroy, id: @cart_related_product
    end

    assert_redirected_to cart_related_products_path
  end
end
