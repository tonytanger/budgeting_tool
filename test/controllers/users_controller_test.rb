require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get sign_in" do
    get :sign_in
    assert_response :success
  end

  # test "should get show" do
  #   get :show
  #   assert_response :success
  # end

  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get :edit
  #   assert_response :success
  # end

  # test "should get delete" do
  #   get :delete
  #   assert_response :success
  # end

end
