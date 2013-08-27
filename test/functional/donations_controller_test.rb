require 'test_helper'

class DonationsControllerTest < ActionController::TestCase
  setup do
    @donation = donations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:donations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create donation" do
    assert_difference('Donation.count') do
      post :create, donation: { charity_id: @donation.charity_id, comments: @donation.comments, email: @donation.email, flask_purchased: @donation.flask_purchased, name: @donation.name, newsletter: @donation.newsletter, place_of_purchase: @donation.place_of_purchase, serial_number: @donation.serial_number }
    end

    assert_redirected_to donation_path(assigns(:donation))
  end

  test "should show donation" do
    get :show, id: @donation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @donation
    assert_response :success
  end

  test "should update donation" do
    put :update, id: @donation, donation: { charity_id: @donation.charity_id, comments: @donation.comments, email: @donation.email, flask_purchased: @donation.flask_purchased, name: @donation.name, newsletter: @donation.newsletter, place_of_purchase: @donation.place_of_purchase, serial_number: @donation.serial_number }
    assert_redirected_to donation_path(assigns(:donation))
  end

  test "should destroy donation" do
    assert_difference('Donation.count', -1) do
      delete :destroy, id: @donation
    end

    assert_redirected_to donations_path
  end
end
