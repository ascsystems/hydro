require 'test_helper'

class LineItemOptionsControllerTest < ActionController::TestCase
  setup do
    @line_item_option = line_item_options(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:line_item_options)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create line_item_option" do
    assert_difference('LineItemOption.count') do
      post :create, line_item_option: { line_item_id: @line_item_option.line_item_id, option_id: @line_item_option.option_id, option_name: @line_item_option.option_name }
    end

    assert_redirected_to line_item_option_path(assigns(:line_item_option))
  end

  test "should show line_item_option" do
    get :show, id: @line_item_option
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @line_item_option
    assert_response :success
  end

  test "should update line_item_option" do
    put :update, id: @line_item_option, line_item_option: { line_item_id: @line_item_option.line_item_id, option_id: @line_item_option.option_id, option_name: @line_item_option.option_name }
    assert_redirected_to line_item_option_path(assigns(:line_item_option))
  end

  test "should destroy line_item_option" do
    assert_difference('LineItemOption.count', -1) do
      delete :destroy, id: @line_item_option
    end

    assert_redirected_to line_item_options_path
  end
end
