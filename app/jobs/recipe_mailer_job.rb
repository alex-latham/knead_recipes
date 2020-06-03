class RecipeMailerJob < ApplicationJob
  queue_as :mailer

  def perform(email_info)
    RecipeMailer.inform(email_info).deliver_now
  end
end
