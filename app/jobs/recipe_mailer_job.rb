class RecipeMailerJob < ApplicationJob
  queue_as :mailers

  def perform(email_info)
    RecipeMailer.share_with_friend(email_info).deliver_now
  end
end
