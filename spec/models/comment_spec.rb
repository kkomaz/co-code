require 'rails_helper'

describe Comment, type: :model do

  describe "Comment validations" do
    it "has a valid factory" do
      expect(build(:comment)).to be_valid
    end

    it "is invalid without content" do
      comment = build(:comment, :content => nil)
      comment.valid?

      expect(comment.errors[:content]).to include("can't be blank")
    end

    it "is invalid without a post id" do
      comment = build(:comment, :post_id => nil)
      comment.valid?

      expect(comment.errors[:post_id]).to include("can't be blank")
    end

    it "is invalid without a user id" do
      comment = build(:comment, :user_id => nil)
      comment.valid?

      expect(comment.errors[:user_id]).to include("can't be blank")
    end
  end
end
