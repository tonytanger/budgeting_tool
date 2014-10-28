require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  # 
  def setup
    @user = User.new(password: "test123", password_confirmation: "test123", email: "email@abc", first_name: "john", last_name: "doe")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "missing email" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "missing first name" do
    @user.first_name = " "
    assert_not @user.valid?
  end

  test "missing last name" do
    @user.last_name = " "
    assert_not @user.valid?
  end

  test "passwords must equal" do
    @user.password_confirmation = "test1234"
    assert_not @user.valid?
  end

  test "email must be unique" do
    @user.email = "abc@abc"
    assert !@user.valid?
  end
end
