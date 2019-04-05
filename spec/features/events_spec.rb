require 'rails_helper'

RSpec.feature "Events", type: :feature do
  describe "authenticated user" do
    before do
      @user = FactoryBot.create(:user)
      @user2 = FactoryBot.create(:user)
      @user3 = FactoryBot.create(:user)
      @user4 = FactoryBot.create(:user)

      visit root_path
      click_link "Log in"
      fill_in "Name", with: @user.name
      click_button "Log in to my account"
      click_button "Create new event"
      fill_in "Title", with: "Example Title"
      fill_in "Info", with: "Example information"
      fill_in "Location", with: "Example location"
      @date = 1.week.from_now
      fill_in "Date", with: @date
      check("attendees[]", :visible => false, :match => :first)
      click_button "Create my new event"
    end

    scenario "creates new event" do
      expect(page).to have_content "Event created!"
      expect(page).to have_content "Example Title"
      expect(page).to have_content "Example information"
      expect(page).to have_content "Example location"
      expect(page).to have_content "#{@date.strftime("%A, %d %B, %Y")}"
      expect(page).to have_content "#{@user2.name}" # event attendee
      expect(page).to_not have_content "#{@user3.name}" # not event attendee
      expect(page).to have_current_path("/users/#{@user.id}")
    end

    scenario "attendee views invitation to event" do
      click_link "Log out"
      click_link "Log in"
      fill_in "Name", with: @user2.name
      click_button "Log in to my account"

      expect(page).to have_content "Example Title"
      expect(page).to have_content "Example information"
      expect(page).to have_content "Example location"
      expect(page).to have_content "#{@date.strftime("%A, %d %B, %Y")}"
      expect(page).to have_content "#{@user.name}" # event creator
      expect(page).to have_content "#{@user2.name}" # event attendee
      expect(page).to_not have_content "#{@user3.name}" # not event attendee
      expect(page).to have_current_path("/users/#{@user2.id}")
    end

    scenario "non-attendee does not receive invitation to event" do
      click_link "Log out"
      click_link "Log in"
      fill_in "Name", with: @user3.name
      click_button "Log in to my account"

      expect(page).to_not have_content "Example Title"
      expect(page).to_not have_content "#{@user.name}" # event creator
      expect(page).to have_current_path("/users/#{@user3.id}")
    end

    scenario "attempts (unsuccesfully) to create event with invalid details" do
      click_button "Create new event"
      fill_in "Title", with: ""
      fill_in "Location", with: ""
      @date = 1.week.from_now
      fill_in "Date", with: @date
      click_button "Create my new event"
      expect(page).to have_content "The form contains 3 errors."
      expect(page).to have_content "Title can't be blank"
      expect(page).to have_content "Location can't be blank"
      expect(page).to have_content "Attendees can't be none"
      expect(page).to have_current_path("/events")
    end

    scenario "attempts (unsuccesfully) to view other user's events" do
      visit("/users/#{@user4.id}")
      expect(page).to_not have_content "#{@user4.name}"
      expect(page).to have_current_path("/users/#{@user.id}")
    end
  end

  describe "unauthenticated user" do
    before do
      @user = FactoryBot.create(:user)
    end

    scenario "attempts (unsuccesfully) to view a user's events" do
      visit("/users/#{@user.id}")
      expect(page).to have_content "Please log in."
      expect(page).to_not have_content "#{@user.name}"
      expect(page).to have_current_path(login_path)
    end

    scenario "attempts (unsuccesfully) to access new event page" do
      visit("/events/new")
      expect(page).to have_content "Please log in."
      expect(page).to_not have_content "#{@user.name}"
      expect(page).to have_current_path(login_path)
      visit("/events")
      expect(page).to have_content "Please log in."
      expect(page).to_not have_content "#{@user.name}"
      expect(page).to have_current_path(login_path)
    end
  end
end
