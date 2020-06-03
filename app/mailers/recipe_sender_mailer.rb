class RecipeSenderMailer < ApplicationMailer
  def inform(email_info, friend_email)
    @sent_by = email_info[:sent_by]
    @recipe_id = email_info[:recipe_id]
    @recipe_title = email_info[:recipe_title]
    @friend = email_info[:friend_email]
    mail(to: friend_email, subject: "#{@sent_by} has sent you a recipe!")
  end
end
