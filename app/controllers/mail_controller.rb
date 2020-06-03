class MailController < ApplicationController
  before_action :require_user

  def create
    @friends = current_user.friends
    @friends.each do |friend|
      email_info = {
        sent_by: current_user,
        to: friend.name,
        recipe_title: params[:title],
        recipe_id: params[:id],
      }
      RecipeSenderMailer.inform(email_info, friend.email).deliver_now
    end
    flash['alert alert-success'] = 'This recipe has been sent to ALL of your friends'
    redirect_back(fallback_location: root_path)
  end
end
