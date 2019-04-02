require 'rails_helper'

RSpec.describe User, type: :model do
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
end
