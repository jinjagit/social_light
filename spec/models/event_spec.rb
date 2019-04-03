require 'rails_helper'

RSpec.describe Event, type: :model do
  it "is valid with title, info., location, date, and creator_id" do
    user = User.create(name: "Aaron")
    event = Event.new(
      title: "Birthday Party!",
      info: "Buffet provided",
      location: "My house",
      date: Time.now,
      creator_id: user.id
    )
    expect(event).to be_valid
  end

  it "is invalid without a title" do
    event = Event.new(title: nil)
    event.valid?
    expect(event.errors[:title]).to include("can't be blank")
  end

  it "is invalid with a title of more than 36 characters in length" do
    event = Event.new(title: 'a' * 37)
    event.valid?
    expect(event.errors[:title]).to include("is too long (maximum is 36 characters)")
  end

  it "is invalid with info. of more than 36 characters in length" do
    event = Event.new(info: 'a' * 37)
    event.valid?
    expect(event.errors[:info]).to include("is too long (maximum is 36 characters)")
  end

  it "is invalid without a location" do
    event = Event.new(location: nil)
    event.valid?
    expect(event.errors[:location]).to include("can't be blank")
  end

  it "is invalid with a location of more than 36 characters in length" do
    event = Event.new(location: 'a' * 37)
    event.valid?
    expect(event.errors[:location]).to include("is too long (maximum is 36 characters)")
  end

  it "is invalid without a creator" do
    event = Event.new(creator_id: nil)
    event.valid?
    expect(event.errors[:creator_id]).to include("can't be blank")
  end
end
