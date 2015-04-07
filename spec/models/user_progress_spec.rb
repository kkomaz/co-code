require 'rails_helper'

RSpec.describe UserProgress, type: :model do
  describe "UserProgress validations" do 
    it "has a valid factory" do
      expect(create(:user_progress)).to be_valid
    end

    it "is invalid without a user id" do
      user_progress = build(:user_progress, :user => nil)
      expect(user_progress).not_to be_valid
    end

    it "is invalid without a language_problem id" do
      user_progress = build(:user_progress, :language_problem => nil)
      expect(user_progress).not_to be_valid
    end

    it "is invalid without a status" do
      user_progress = build(:user_progress, :status => nil)
      expect(user_progress).not_to be_valid
    end

    it "is invalid without a favorite" do
      user_progress = build(:user_progress, :favorite => nil)
      expect(user_progress).not_to be_valid
    end

    it "is invalid with status greater than 2" do
      user_progress = build(:user_progress, :status => 3)
      expect(user_progress).not_to be_valid
    end

    it "is invalid with status less than 0" do
      user_progress = build(:user_progress, :status => -1)
      expect(user_progress).not_to be_valid
    end

    it "is invalid with status with a float value" do
      user_progress = build(:user_progress, :status => 1.5)
      expect(user_progress).not_to be_valid
    end
  end

  describe "UserProgress methods" do 
    it "sets user progress status to 1 for problem 1 when new language sign-up" do 
      user1 = create(:user, :id => 1)
      language = create(:language, :id => 1,)
      language_problem_1 = create(:language_problem, :language_id => 1, :problem_id => 1)
      language_problem_2 = create(:language_problem, :language_id => 1, :problem_id => 2)

      user_progress = UserProgress.build_user_progress(language_problem_1, user1)
      expect(user_progress.user).to eq(user1)
    end
  end
end
