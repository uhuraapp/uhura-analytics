ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  address: ENV['SMTP_ADDRESS'],
  port: ENV['SMTP_PORT'],
  domain: ENV['SMTP_DOMAIN'],
  user_name: ENV['SMTP_USERNAME'],
  password: ENV['SMTP_PASSWORD'],
  authentication: :login,
  ssl: true,
  tls: true,
  enable_starttls_auto: true
}

settings = ActionMailer::Base.smtp_settings
smtp = Net::SMTP.new settings[:address], settings[:port]
smtp.enable_starttls_auto if settings[:enable_starttls_auto]
smtp.start(settings[:domain]) do
  smtp.authenticate settings[:user_name], settings[:password], settings[:authentication]
end
