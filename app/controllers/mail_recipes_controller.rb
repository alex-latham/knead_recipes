class MailRecipesController < ApplicationController
  before_action :require_user

  def create
    current_user.friends.each do |friend|
      email_info = {
        from_user: current_user,
        to_user: friend,
        recipe_title: params[:title],
        recipe_id: params[:id],
      }
      RecipeMailerJob.perform_now(email_info)
      # RecipeMailerJob.perform_later(email_info)
      # RecipeMailer.inform(email_info).deliver_now
    end
    flash['alert alert-success'] = 'This recipe has been sent to ALL of your friends'
    redirect_back(fallback_location: root_path)
  end
end
