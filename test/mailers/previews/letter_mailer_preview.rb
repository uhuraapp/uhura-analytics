# Preview all emails at http://localhost:3000/rails/mailers/letter_mailer
class LetterMailerPreview < ActionMailer::Preview
  def show
    user = User.last
    letter = Letter.last
    LetterMailer.prepare(letter.id, user.email)
  end
end
