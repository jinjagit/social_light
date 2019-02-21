require 'test_helper'

class CreateEventTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
  end

  test "create event with invalid information" do
    get login_path
    post login_path, params: { session: { name: @user.name } }
    assert is_logged_in?
    get new_event_path
    assert_template 'events/new'
    assert_no_difference 'Event.count' do
      post events_path, params: { event: {title: "     ", info: "info",
                                  location: "location", date: "2019-04-16",
                                  creator_id: @user.id} }
    end
    assert_template 'events/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "create event with valid information" do
    get login_path
    post login_path, params: { session: { name: @user.name } }
    assert is_logged_in?
    get new_event_path
    assert_template 'events/new'
    assert_difference 'Event.count', 1 do
      post events_path, params: { event: {title: "title", info: "info",
                                  location: "location", date: "2019-04-16",
                                  creator_id: @user.id} }
    end
    assert_not flash.empty?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
  end
end
