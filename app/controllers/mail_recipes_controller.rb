class MailRecipesController < ApplicationController
  before_action :require_user

  def create
    current_user.friends.each do |friend|
      email_info = {
        user: current_user.username,
        friend: friend.username,
        friend_email: friend.email,
        recipe_title: params[:title],
        recipe_id: params[:id],
      }
      # RecipeMailerJob.perform_now(email_info)
      # RecipeMailerJob.perform_later(email_info)
      RecipeMailer.share_with_friend(email_info).deliver_now
    end

    flash['alert alert-success'] = 'This recipe has been sent to ALL of your friends'
    redirect_back(fallback_location: root_path)
  end
end
