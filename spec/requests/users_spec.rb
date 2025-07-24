require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:users) { create_list(:user, 2) }
  before(:each) do
    @user = users.first
  end
  after(:each) do
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
      get "/users/:id"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /users" do
    let(:valid_params) { { email: "testUser@bitscollege.edu.et", password: "password123" } }
    it "creates a user" do
      post "/users", params: valid_params
      expect(response).to have_http_status(201)
      expect(User.count).to eq(3)
    end
  end

  describe "PATCH /users" do
    it "updates a single user" do
      patch "/users/:id"
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE /users" do
    it "deletes a single user" do
      get "/users/:id"
      expect(response).to have_http_status(:success)
    end
  end
end
