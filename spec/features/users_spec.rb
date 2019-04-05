require 'rails_helper'

RSpec.feature "Users", type: :feature do
  describe "user authentication" do
    before do
      @user = FactoryBot.create(:user)

      visit root_path
      click_link "Log in"
      fill_in "Name", with: @user.name
      click_button "Log in to my account"
    end

    scenario "user signs in" do
      expect(page).to have_content "My events:"
      expect(page).to have_content "Invitation"
      within "#name" do
        expect(page).to have_content "#{@user.name}"
      end
      expect(page).to have_current_path("/users/#{@user.id}")
    end

    scenario "user signs out" do
      click_link "Log out"

      expect(page).to have_content "Welcome to Social Light!"
      expect(page).to have_content "Log in"
      expect(page).to_not have_content "#{@user.name}"
      expect(page).to have_current_path(root_path)
    end
  end

  describe "user creation" do
    scenario "new user signs up" do
      visit root_path
      click_link "Sign up"
      fill_in "Name", with: "Nancy Newuser"
      click_button "Create my account"

      expect(page).to have_content "Account creation successful!"
      within "#name" do
        expect(page).to have_content "Nancy Newuser"
      end
      expect(page).to have_content "no events created."
      expect(page).to have_content "no invitations received."
    end
  end
end
