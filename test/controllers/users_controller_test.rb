require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    @other_user = users(:two)
  end

  test "should redirect show when not logged in" do
    get user_path(@user)
    assert_redirected_to login_url
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should redirect show action when not logged in" do
    get user_path(@user)
    assert_redirected_to login_path
    assert_not flash.empty?
    assert_equal "Please log in.", flash[:danger]
  end

  test "should redirect attempt to access other user's show action when logged in" do
    get login_path
    post login_path, params: { session: { name: @user.name } }
    assert is_logged_in?
    get user_path(@other_user)
    assert_equal(@request.params[:id], @other_user.id.to_s)
    assert_redirected_to @user
  end
end
