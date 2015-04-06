require 'rails_helper'

RSpec.describe User, type: :model do

  it "has a valid factory" do
    expect(create(:user)).to be_valid
  end

  it "is invalid without a first name" do
    user = build(:user, :first_name => nil)
    expect(user).not_to be_valid
  end

  it "is invalid without a last name" do
    user = build(:user, :last_name => nil)
    expect(user).not_to be_valid
  end

  it "is invalid without an email address" do
    user = build(:user, :email => nil)
    expect(user).not_to be_valid
  end

  it "is invalid without a valid email format" do
    user = build(:user, :email => "bad--email@bad")
    expect(user).not_to be_valid
  end

  it "is invalid if email adress is not unique" do
    user1 = create(:user, :email => "test@test.com")
    user2 = build(:user, :email => "test@test.com")
    expect(user2).not_to be_valid
  end

  it "is invalid with a non-matching password confirmation" do
    user = build(:user, :password => "ponies13", :password_confirmation => "13ponies")
    expect(user).not_to be_valid
  end

end
