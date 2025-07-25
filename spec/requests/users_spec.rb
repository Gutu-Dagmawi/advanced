require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:users) { create_list(:user, 2) }
  after :each do
    User.destroy_all
  end

  describe "GET /users" do
    it "returns all users" do
      get "/users"
      parsed = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(parsed.count).to eq(User.count)
    end
  end

  describe "GET /users/:id" do
    it "returns a single user" do
      user = users.first
      get "/users/#{user.id}"

      parsed = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(parsed["id"]).to eq(user.id)
      expect(parsed["email"]).to eq(user.email)
    end
  end

  describe "POST /users" do
    let(:valid_params) { { email: "testUser@bitscollege.edu.et", password: "password123" } }
    it "creates a user" do
      post "/users", params: valid_params
      expect(response).to have_http_status(:created)
      expect(User.count).to eq(3)
    end
  end

  describe "PATCH /users" do
    it "updates a single user" do
      user = users.first
      patch "/users/#{user.id}", params: { email: "updatedUser@bitscollege.edu.et" }
      expect(response).to have_http_status(:ok)
      user.reload
      expect(user.email).to eq("updatedUser@bitscollege.edu.et")
    end
  end

  describe "DELETE /users" do
    it "deletes a single user" do
      user = users.first
      delete "/users/#{user.id}"
      expect(response).to have_http_status(:no_content)
      expect(User.exists?(user.id)).to be_falsey
    end
  end
end
