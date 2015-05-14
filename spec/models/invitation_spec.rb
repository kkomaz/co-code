require 'rails_helper'

describe Invitation, type: :model do
  describe 'Invitation validations' do
    it "has a valid factory" do
      expect(build(:invitation)).to be_valid
    end
  end
end
