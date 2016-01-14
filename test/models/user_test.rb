require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test ".opted_out" do
    assert_equal User.opted_out, []

    user = users(1)
    Mailkick::OptOut.create(user_type: "User", active: true, user_id: user.id)
    Mailkick::OptOut.create(user_type: "User", active: false, user_id: user.id+1)

    assert_equal User.opted_out, [user]
    assert_equal User.opted_out(list: 'my-list'), []

    user = users(2)
    Mailkick::OptOut.create(user_type: "User", active: true, list: 'my-list', user_id: user.id)

    assert_equal User.opted_out(list: 'my-list'), [user]

    assert_equal User.opted_out(not: true), [users(2), users(3), users(4)]
    assert_equal User.opted_out(list: 'my-list', not: true), [users(1), users(3), users(4)]
  end

  test ".not_opted_out" do
    user = users(1)
    Mailkick::OptOut.create(user_type: "User", active: true, user_id: user.id)

    assert_not_equal User.not_opted_out, [user]
    assert_not_equal User.not_opted_out(list: 'my-list'), []

    user = users(2)
    Mailkick::OptOut.create(user_type: "User", active: true, list: 'my-list', user_id: user.id)

    assert_not_equal User.not_opted_out(list: 'my-list'), [user]

    assert_equal User.not_opted_out, [users(2), users(3), users(4)]
    assert_equal User.not_opted_out(list: 'my-list'), [users(1), users(3), users(4)]
  end

  test "#opted_out?" do
    user = users(1)
    assert_equal user.opted_out?, false

    with Mailkick::OptOut, {user_type: "User", active: false, user_id: user.id} do
      assert_equal user.opted_out?, false
    end

    with Mailkick::OptOut, {user_type: "User", active: true, user_id: user.id} do
      assert_equal user.opted_out?, true
    end

    with Mailkick::OptOut, {user_type: "User", active: true, user_id: user.id, list: 'newsletter'} do
      assert_equal user.opted_out?, false
      assert_equal user.opted_out?(list: 'newsletter'), true
    end
  end

  test "#opt_out" do
    user = users(1)
    assert_equal user.opted_out?, false
    assert_equal user.opted_out?(list: 'newsletter'), false

    user.opt_out(list: 'newsletter')
    assert_equal user.opted_out?, false
    assert_equal user.opted_out?(list: 'newsletter'), true

    user.opt_out()
    assert_equal user.opted_out?, true
    assert_equal user.opted_out?(list: 'newsletter'), true
  end

  test "#opt_in" do
    user = users(1)

    user.opt_out(list: 'newsletter')
    user.opt_in(list: 'newsletter')

    assert_equal user.opted_out?, false
    assert_equal user.opted_out?(list: 'newsletter'), false

    user.opt_out
    user.opt_in
    assert_equal user.opted_out?, false
    assert_equal user.opted_out?(list: 'newsletter'), false
  end
end
