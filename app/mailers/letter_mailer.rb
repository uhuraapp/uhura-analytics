require 'cgi'

class LetterMailer < ApplicationMailer
  attr_reader :letter, :user

  def prepare(id, email)
    @letter = Letter.find id
    @user = User.where(email: email).first
    body = h @letter.body
    subject = h @letter.subject

    mail to: email, subject: subject do |format|
      format.html { render inline: body }
    end
  end

  protected

  def h(data)
    ERB.new(CGI.unescapeHTML(data)).result binding
  end
end
