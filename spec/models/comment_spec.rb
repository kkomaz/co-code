require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "Comment validations" do
    it "has a valid factory" do
      expect(create(:comment)).to be_valid
    end

    it "is valid with a user_id, post_id, and content" do
      comment = Comment.new(user_id: 1, post_id: 1, content: "Comment content")
      expect(comment).to be_valid
    end

    it "is invalid without content" do
      comment = build(:comment, :content => nil)
      expect(comment).not_to be_valid
    end

    it "is invalid without a post id" do
      comment = build(:comment, :post => nil)
      expect(comment).not_to be_valid
    end

    it "is invalid without a user id" do
      comment = build(:comment, :user => nil)
      expect(comment).not_to be_valid
    end
  end
end
