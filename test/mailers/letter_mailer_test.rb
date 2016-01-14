require 'test_helper'

class LetterMailerTest < ActionMailer::TestCase
  test "deliver" do
    letter = letters(:one)
    user = users(1)
    email = LetterMailer.prepare(letter.id, user.email).deliver_now

    assert_not ActionMailer::Base.deliveries.empty?

    assert_equal ['duke@uhura.io'], email.from
    assert_equal [user.email], email.to
    assert_equal "Hello #{user.email}", email.subject
    assert_equal "Hello #{user.email}, are you user ##{user.id}? Welcome from #{letter.id} letter", ActionView::Base.full_sanitizer.sanitize(email.body.to_s).strip

    message = Ahoy::Message.last
    assert_equal message.letter_id, letter.id
    assert_equal message.user_id, user.id
  end

  test "subscriptions" do
    letter = letters(:one)
    user = users(1)

    email = LetterMailer.prepare(letter.id, user.email, false).deliver_now

    assert_no_match /Don't want to receive emails from me\? Unsubscribe$/, ActionView::Base.full_sanitizer.sanitize(email.body.to_s).strip

    email = LetterMailer.prepare(letter.id, user.email, true).deliver_now

    assert_match /Don't want to receive emails from me\? Unsubscribe$/, ActionView::Base.full_sanitizer.sanitize(email.body.to_s).strip
  end
end
