require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
  end

  test "should redirect new when NOT logged in" do
    get new_event_path
    assert_redirected_to login_path
  end

  test "should get new when logged in" do
    get login_path
    post login_path, params: { session: { name: @user.name } }
    assert is_logged_in?
    get new_event_path
    assert_response :success
  end

end
