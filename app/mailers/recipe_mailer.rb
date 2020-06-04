class RecipeMailer < ApplicationMailer
  def share_with_friend(email_info)
    @user = email_info[:user]
    @friend = email_info[:friend]
    @recipe_title = email_info[:recipe_title]
    @recipe_id = email_info[:recipe_id]
    mail(to: email_info[:friend_email], subject: "#{@user} has sent you a recipe!")
  end
end
