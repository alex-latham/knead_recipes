require 'rails_helper'

RSpec.describe "Nexts", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/next/index"
      expect(response).to have_http_status(:success)
    end
  end

end
