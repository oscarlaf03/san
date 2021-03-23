ActionMailer::Base.smtp_settings = {
  address: "in-v3.mailjet.com",
  port: 587,
  domain: 'sanus.tech',
  user_name: ENV['MAIL_JET_USER_NAME'],
  password: ENV['MAIL_JET_PASSWORD'],
  authentication: :plain,
  enable_starttls_auto: true
}
