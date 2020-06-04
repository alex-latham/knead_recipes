# ActionMailer::Base.smtp_settings = {
#   domain:         'localhost',
#   address:        "smtp.sendgrid.net",
#   port:            587,
#   authentication: :plain,
#   user_name:      'apikey',
#   password:       ENV['SENDGRID_API_KEY']
# }

# ActionMailer::Base.smtp_settings = {
#   address: 'smtp.sendgrid.net',
#   port: 587,
#   domain: 'yourdomain.com',
#   user_name: ENV['SENDGRID_USERNAME'],
#   password: ENV['SENDGRID_PASSWORD'],
#   authentication: :login,
#   enable_starttls_auto: true
# }