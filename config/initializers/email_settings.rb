ActionMailer::Base.smtp_settings = {
  address: ENV['SMTP_ADDRESS'],
  port: ENV['SMTP_PORT'],
  domain: "uhura.io",
  user_name: "support@uhura.io",
  password: ENV['SMTP_PASSWORD'],
  authentication: "plain"
}
