# I am aware that controller tests were 'soft deprecated' in Rails 5.
# These tests are included for my own practice with Rspec.

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#index" do
    it "responds successfully" do
      get :index
      expect(response).to be_successful
    end

    it "returns a 200 response" do
      get :index
      expect(response).to have_http_status "200"
    end
  end

  describe "#show" do
    context "as an authorized user" do
      before do
        @user = FactoryBot.create(:user)
      end

      it "responds successfully" do
        log_in @user
        get :show, params: { id: @user.id }
        expect(response).to be_successful
      end
    end

    context "as an unauthorized user" do
      before do
        @user = FactoryBot.create(:user)
        @other_user = FactoryBot.create(:user)
      end

      it "redirects to current user's events page" do
        log_in @user
        get :show, params: { id: @other_user.id }
        expect(response).to redirect_to user_path(@user)
      end
    end

    context "as an unauthenticated user" do
      before do
        @user = FactoryBot.create(:user)
      end

      it "redirects to log in page" do
        get :show, params: { id: @user.id }
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "#new" do
    it "responds successfully" do
      get :new
      expect(response).to be_successful
    end

    it "returns a 200 response" do
      get :new
      expect(response).to have_http_status "200"
    end
  end

  describe "#create" do
    context "when valid name provided" do
      it "creates a new user" do
        post :create, params: { user: { name: "Example New User" } }
        expect(User.exists?(name: "Example New User")).to eq true
      end

      it "redirects to new user's events page" do
        post :create, params: { user: { name: "Example New User" } }
        @user = User.find_by(name: "Example New User")
        expect(response).to redirect_to user_path(@user)
      end
    end

    context "when invalid name provided" do
      it "does not create new user" do
        @users = User.all
        expect {
          post :create, params: { user: { name: nil } }
        }.to_not change(@users, :count)
      end
    end
  end

end
