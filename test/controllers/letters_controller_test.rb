require 'test_helper'

class LettersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    sign_in users(:one)
    @letter = letters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:letters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create letter" do
    assert_difference('Letter.count') do
      post :create, letter: { body: @letter.body, done: @letter.done, subject: @letter.subject }
    end

    assert_redirected_to letter_path(assigns(:letter))
  end

  test "should show letter" do
    get :show, id: @letter.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @letter.id
    assert_response :success
  end

  test "should update letter" do
    patch :update, id: @letter.id, letter: { body: @letter.body, done: @letter.done, subject: @letter.subject }
    assert_redirected_to letter_path(assigns(:letter))
  end

  test "should destroy letter" do
    assert_difference('Letter.count', -1) do
      delete :destroy, id: @letter
    end

    assert_redirected_to letters_path
  end

  test "should deliver letter" do
    user = users(:one)
    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      post :deliver, id: @letter.id, email: user.email
    end

    letter_email = ActionMailer::Base.deliveries.last

    assert_equal "Hello #{user.email}", letter_email.subject
    assert_equal 'duke@duke.com', letter_email.to[0]
    assert_match /Hello #{user.email}, are you user/, letter_email.body.to_s
  end
end
