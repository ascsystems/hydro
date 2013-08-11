require 'test_helper'

class ProductOptionValueImagesControllerTest < ActionController::TestCase
  setup do
    @product_option_value_image = product_option_value_images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_option_value_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_option_value_image" do
    assert_difference('ProductOptionValueImage.count') do
      post :create, product_option_value_image: { default_image: @product_option_value_image.default_image, product_image_id: @product_option_value_image.product_image_id, product_option_value_id: @product_option_value_image.product_option_value_id }
    end

    assert_redirected_to product_option_value_image_path(assigns(:product_option_value_image))
  end

  test "should show product_option_value_image" do
    get :show, id: @product_option_value_image
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_option_value_image
    assert_response :success
  end

  test "should update product_option_value_image" do
    put :update, id: @product_option_value_image, product_option_value_image: { default_image: @product_option_value_image.default_image, product_image_id: @product_option_value_image.product_image_id, product_option_value_id: @product_option_value_image.product_option_value_id }
    assert_redirected_to product_option_value_image_path(assigns(:product_option_value_image))
  end

  test "should destroy product_option_value_image" do
    assert_difference('ProductOptionValueImage.count', -1) do
      delete :destroy, id: @product_option_value_image
    end

    assert_redirected_to product_option_value_images_path
  end
end
