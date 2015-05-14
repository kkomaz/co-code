require 'rails_helper'

describe Invitation, type: :model do

  it "has a valid factory" do
    expect(build(:invitation)).to be_valid
  end

  it "is invalid without a lesson" do
    invitation = build(:invitation, lesson: nil)
    invitation.valid?

    expect(invitation.errors[:lesson]).to include("can't be blank")
  end

  it "is invalid without a user" do
    invitation = build(:invitation, user: nil)
    invitation.valid?

    expect(invitation.errors[:user]).to include("can't be blank")
  end

  describe '::create_invitations' do
    it "creates invitations for users"
    it "doesn't create invitations for all users"
  end
end
