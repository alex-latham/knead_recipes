class RecipeMailer < ApplicationMailer
  def inform(email_info)
    @from_user = email_info[:from_user]
    @to_user = email_info[:to_user]
    @recipe_title = email_info[:recipe_title]
    @recipe_id = email_info[:recipe_id]
    mail(to: @to_user.email, subject: "#{@from_user.username} has sent you a recipe!")
  end
end
