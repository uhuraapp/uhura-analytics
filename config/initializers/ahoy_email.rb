class LetterSubscriber
  def open(event)
    ahoy = event[:controller].ahoy
    ahoy.track "letter-opened", message_id: event[:message].id
  end

  def click(event)
    ahoy = event[:controller].ahoy
    ahoy.track "letter-clicked", message_id: event[:message].id, url: event[:url]
  end
end

AhoyEmail.subscribers << LetterSubscriber.new
