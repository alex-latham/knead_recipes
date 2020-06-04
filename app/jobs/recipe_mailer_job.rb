class RecipeMailerJob < ApplicationJob
  queue_as :mailer

  def perform(email_info)
    RecipeMailer.share_with_friend(email_info).deliver_now
  end
end
