require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example Name")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 25
    assert_not @user.valid?
  end

  test "names should be unique" do
    duplicate_user = @user.dup
    duplicate_user.name = @user.name.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
end
