require 'test_helper'

class LetterMailerTest < ActionMailer::TestCase
  test "send_letter" do
    letter = letters(:one)
    user = users(:one)
    email = LetterMailer.prepare(letter.id, user.email).deliver_now

    assert_not ActionMailer::Base.deliveries.empty?

    assert_equal ['duke@uhura.io'], email.from
    assert_equal [user.email], email.to
    assert_equal "Hello duke@duke.com", email.subject
    assert_equal "Hello #{user.email}, are you user ##{user.id}? Welcome from #{letter.id} letter", ActionView::Base.full_sanitizer.sanitize(email.body.to_s).strip
    end
end
