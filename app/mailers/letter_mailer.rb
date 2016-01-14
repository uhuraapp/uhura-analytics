require 'cgi'

class LetterMailer < ApplicationMailer
  attr_reader :letter, :user

  include ActionView::Helpers::UrlHelper
  include Mailkick::UrlHelper

  def prepare(id, email, can_unsubscribe = false)
    @letter = Letter.find id
    @user = User.where(email: email).first

    if @user.email != email
      puts "Not Found user email #{email}"
      return
    end

    letter_body = @letter.body
    letter_body = unsubscribed_link(letter_body) if can_unsubscribe

    body = h letter_body
    subject = h @letter.subject

    track user: @user, utm_campaign: letter.uid, extra: {letter_id: @letter.id}

    mail to: email, subject: subject do |format|
      format.html { render inline: body }
    end
  end

  protected

  def h(data)
    ERB.new(CGI.unescapeHTML(data)).result binding
  end

  def unsubscribed_link(body)
    _body = body
    _body += "<br />Don't want to receive emails from me? <%= link_to 'Unsubscribe', mailkick_unsubscribe_url %>"
    _body
  end
end
