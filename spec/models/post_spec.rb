require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "Post validations" do 
    it "has a valid factory" do
      expect(create(:post)).to be_valid
    end

    it "is invalid without title" do
      post = build(:post, :title => nil)
      expect(post).not_to be_valid
    end

    it "is invalid without a content" do
      post = build(:post, :content => nil)
      expect(post).not_to be_valid
    end

    it "is invalid without a language_problem id" do
      post = build(:post, :language_problem => nil)
      expect(post).not_to be_valid
    end

    it "is invalid without a user id" do
      post = build(:post, :user => nil)
      expect(post).not_to be_valid
    end
  end
end
