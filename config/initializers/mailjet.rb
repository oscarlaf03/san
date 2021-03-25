Mailjet.configure do |config|
  config.api_key =  ENV["JET_MAIL_KEY"]
  config.secret_key =  ENV["JET_MAIL_SECRET"]
  config.default_from = "info@sanus.tech"
end
