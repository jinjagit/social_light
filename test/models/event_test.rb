require 'test_helper'

class EventTest < ActiveSupport::TestCase

  def setup
    @user = users(:one)
    @event = Event.new(title: "title", info: "info", location: "location",
                        date: Time.now, creator_id: @user.id)
  end

  test "should be valid" do
    assert @event.valid?
  end

  test "title should be present" do
    @event.title = "     "
    assert_not @event.valid?
  end

  test "title should not be too long" do
    @event.title = "a" * 37
    assert_not @event.valid?
  end

  test "info should not be too long" do
    @event.info = "a" * 37
    assert_not @event.valid?
  end

  test "location should be present" do
    @event.location = "     "
    assert_not @event.valid?
  end

  test "location should not be too long" do
    @event.location = "a" * 37
    assert_not @event.valid?
  end

  test "date should be present" do
    @event.date = "     "
    assert_not @event.valid?
  end
end
