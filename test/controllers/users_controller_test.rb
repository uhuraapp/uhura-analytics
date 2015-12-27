require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(1)
    sign_in admins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end
end
