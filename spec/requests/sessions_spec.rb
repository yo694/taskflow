require 'rails_helper'

RSpec.describe "API Sessions", type: :request do
  describe "POST /api/v1/sessions" do
    it "returns a token with valid credentials" do
      user = create(:user)

      post "/api/v1/sessions", params: {
        email: user.email,
        password: "password123"
      }

      expect(response).to have_http_status(:created)

      body = JSON.parse(response.body)

      expect(body["token"]).to be_present
    end

    it "returns 401 with invalid credentials" do
      user = create(:user)

      post "/api/v1/sessions", params: {
        email: user.email,
        password: "wrongpassword"
      }

      expect(response).to have_http_status(:unauthorized)

      body = JSON.parse(response.body)

      expect(body["error"]).to eq("invalid credentials")
    end
  end
end