require "rails_helper"

RSpec.describe RecipeMailer, type: :mailer do
  describe "mails a recipe" do
    email_info = {
      user: "User",
      friend: "Friend",
      friend_email: "friend@example.com",
      recipe_title: "Sangria",
      recipe_id: 553532,
    }

    let (:email_info) { email_info }
    let(:mail) { RecipeMailer.share_with_friend(email_info) }

    it "renders the headers" do
      expect(mail.subject).to eq("#{email_info[:user]} has sent you a recipe!")
      expect(mail.to).to eq([email_info[:friend_email]])
      expect(mail.from).to eq(["alexlthm@gmail.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("#{email_info[:user]} has sent you a recipe.")
    end
  end
end
