require 'test_helper'

class OptionTypesControllerTest < ActionController::TestCase
  setup do
    @option_type = option_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:option_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create option_type" do
    assert_difference('OptionType.count') do
      post :create, option_type: { name: @option_type.name }
    end

    assert_redirected_to option_type_path(assigns(:option_type))
  end

  test "should show option_type" do
    get :show, id: @option_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @option_type
    assert_response :success
  end

  test "should update option_type" do
    put :update, id: @option_type, option_type: { name: @option_type.name }
    assert_redirected_to option_type_path(assigns(:option_type))
  end

  test "should destroy option_type" do
    assert_difference('OptionType.count', -1) do
      delete :destroy, id: @option_type
    end

    assert_redirected_to option_types_path
  end
end
