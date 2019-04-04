# I am aware that controller tests were 'soft deprecated' in Rails 5.
# These tests are included for my own practice with Rspec.

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe "#new" do
    context "as authenticated user" do
      before do
        @user = FactoryBot.create(:user)
        log_in @user
      end

      it "responds successfully" do
        get :new
        expect(response).to be_successful
      end

      it "returns a 200 response" do
        get :new
        expect(response).to have_http_status "200"
      end
    end

    context "as unauthenticated user" do
      it "redirects to log in page" do
        log_out
        get :new
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "#create" do
    context "with valid event form details" do
      before do
        @user = FactoryBot.create(:user)
        log_in @user
        @event_params = FactoryBot.attributes_for(:event, creator: @user)
        @other_user = FactoryBot.create(:user)
        @attendance_params = ["#{@other_user.id}", '0']
      end

      it "creates a new event" do
        expect {
          post :create, params: { event: @event_params, attendees: @attendance_params }
        }.to change(@user.events, :count).by(1)
      end

      it "returns a 200 response" do
        expect(response).to have_http_status "200"
      end
    end

    context "with invalid event details" do
      it "does not create a new event" do
        @user = FactoryBot.create(:user)
        log_in @user
        @other_user = FactoryBot.create(:user)
        attendance_params = ["#{@other_user.id}", '0']
        expect {
          post :create, params: { event: {title: nil, info: nil, location: nil,
            date: nil }, attendees: attendance_params }
        }.to_not change(@user.events, :count)
      end
    end

    context "with no attendee(s) selected" do
      it "does not create a new event" do
        @user = FactoryBot.create(:user)
        log_in @user
        event_params = FactoryBot.attributes_for(:event, creator: @user)
        @other_user = FactoryBot.create(:user)
        attendance_params = ['0']
        expect {
          post :create, params: { event: event_params, attendees: attendance_params }
        }.to_not change(@user.events, :count)
      end
    end
  end
end
