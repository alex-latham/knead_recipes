require 'rails_helper'

RSpec.describe RecipeMailerJob, type: :job do
  describe "#perform_later" do
    email_info = {
      user: "User",
      friend: "Friend",
      friend_email: "friend@example.com",
      recipe_title: "Sangria",
      recipe_id: 553532,
    }

    let(:email_info) { email_info }

    it "puts a recipe mailer in the queue" do
      ActiveJob::Base.queue_adapter = :test

      expect {
        RecipeMailerJob.set(queue: :recipe).perform_later(email_info)
      }.to have_enqueued_job.with(email_info).on_queue(:recipe).at(:no_wait)
    end
  end
end
