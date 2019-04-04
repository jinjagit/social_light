# I am aware that controller tests were 'soft deprecated' in Rails 5.
# These tests are included for my own practice with Rspec.

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe "#home" do
    it "responds successfully" do
      get :home
      expect(response).to be_successful
    end

    it "returns a 200 response" do
      get :home
      expect(response).to have_http_status "200"
    end
  end
end
