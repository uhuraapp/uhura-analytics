class LetterMailer < ApplicationMailer
  default from: 'duke@uhura.io'

  attr_reader :letter, :email, :user

  def send_letter(id, email)
    @letter = Letter.find id
    @user = User.where(email: email).first

    body = ERB.new(letter.body).result binding

    mail to: email, subject: letter.subject do |format|
      format.html { render inline: body }
    end
  end
end
