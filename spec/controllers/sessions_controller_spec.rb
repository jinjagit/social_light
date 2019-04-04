# I am aware that controller tests were 'soft deprecated' in Rails 5.
# These tests are included for my own practice with Rspec.

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
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
    context "when valid login credentials provided" do
      it "logs in user" do
        log_out
        @user = FactoryBot.create(:user)
        post :create, params: { session: { name: @user.name } }
        expect(logged_in?).to eq true
      end

      it "redirects to user's events page" do
        log_out
        @user = FactoryBot.create(:user)
        post :create, params: { session: { name: @user.name } }
        expect(response).to redirect_to user_path(@user)
      end
    end

    context "when invalid login credentials provided" do
      it "does not log in any user" do
        post :create, params: { session: { name: "NOT name of existing user" } }
        expect(logged_in?).to eq false
      end
    end
  end

  describe "#destroy" do
    it "logs out current user" do
      get :destroy
      expect(logged_in?).to eq false
    end

    it "redirects to root (home page)" do
      get :destroy
      expect(response).to redirect_to root_path
    end
  end
end
