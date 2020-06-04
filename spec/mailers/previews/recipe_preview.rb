# Preview all emails at http://localhost:3000/rails/mailers/recipe
class RecipePreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/recipe/share_with_friend
    def share_with_friend
      email_info = {
        user: "User",
        friend: "Friend",
        friend_email: "friend@example.com",
        recipe_title: "Sangria",
        recipe_id: 553532,
      }
      RecipeMailer.share_with_friend(email_info)
    end
end
