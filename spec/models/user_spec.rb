require 'rails_helper'

RSpec.describe User, type: :model do
  #it "has a valid factory" do
    #expect(FactoryBot.build(:user)).to be_valid
  #end

  it "is valid with (only) a name" do
    user = User.new(name: "Aaron")
    expect(user).to be_valid
  end

  it "is invalid without a name" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it "is invalid with a name of more than 24 characters in length" do
    user = User.new(name: 'a' * 25)
    user.valid?
    expect(user.errors[:name]).to include("is too long (maximum is 24 characters)")
  end

  it "is invalid with a duplicate name" do
    User.create(name: "Aaron")
    user = User.new(name: "Aaron")

    user.valid?
    expect(user.errors[:name]).to include("has already been taken")
  end

  it "can create multiple events" do
    user = FactoryBot.create(:user)
    event = FactoryBot.create(:event, creator_id: user.id)

    expect(event).to be_valid

    event = FactoryBot.create(:event, creator_id: user.id)

    expect(event).to be_valid
    expect(Event.where(creator_id: user.id).count).to eq 2
  end

  it "can attend multiple events" do
    user = FactoryBot.create(:user)
    other_user = FactoryBot.create(:user)

    expect(user.id).to_not eq other_user.id

    event = FactoryBot.create(:event, creator_id: user.id)
    other_event = FactoryBot.create(:event, creator_id: user.id)
    Attendance.create(event_id: event.id, user_id: other_user.id)
    Attendance.create(event_id: other_event.id, user_id: other_user.id)

    expect(Attendance.where(user_id: other_user.id).count).to eq 2
  end
end
