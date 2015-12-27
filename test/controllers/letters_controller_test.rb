require 'test_helper'

class LettersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    sign_in admins(:one)
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

  test "should deliver letter to a user" do
    user = users(1)
    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      post :deliver, id: @letter.id, letter: { email: user.email }
    end

    letter_email = ActionMailer::Base.deliveries.last

    assert_equal "Hello #{user.email}", letter_email.subject
    assert_equal user.email, letter_email.to[0]
    assert_match /Hello #{user.email}, are you user/, letter_email.body.to_s
  end

  test "should deliver letter to all users" do
    all_users = users()
    assert_difference 'ActionMailer::Base.deliveries.size', all_users.size do
      post :deliver, id: @letter.id, all: true
    end

    letter_email = ActionMailer::Base.deliveries.last

    assert_match /Hello /, letter_email.subject
    assert_match /Hello .+, are you user/, letter_email.body.to_s
  end

  test "should deliver only if user never receive" do
    all_users = users()
    received = all_users.to_a.shuffle.take(2)
    received.each do |u|
       Ahoy::Message.create!(user_id: u.id, letter_id: @letter.id)
    end

    assert_difference 'ActionMailer::Base.deliveries.size', (all_users.size) - received.size do
      post :deliver, id: @letter.id, all: true, letter: { unique_send: true }
    end
  end
end
