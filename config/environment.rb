# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# ActionMailer::Base.smtp_settings = {
#   :user_name => 'alexlath',
#   :password => ENV['SENDGRID_PW'],
#   :domain => 'heroku.com',
#   :address => 'smtp.sendgrid.net',
#   :port => 465,
#   :authentication => :plain,
#   :enable_starttls_auto => true
# }