class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@knead-recipes.herokuapp.com'
  layout 'mailer'
end
