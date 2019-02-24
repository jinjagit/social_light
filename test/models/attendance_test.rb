require 'test_helper'

class AttendanceTest < ActiveSupport::TestCase

  def setup
    @user = users(:one)
    @other_user = users(:two)
    @event = events(:one)
    @attendance = Attendance.new(event_id: @event.id, user_id: @other_user.id)
  end

  test "should be valid" do
    assert @attendance.valid?
  end
end
