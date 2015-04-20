require 'rails_helper'

RSpec.describe User, type: :model do

  describe "User validations" do

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

  context "instance methods" do
    describe "#full_name" do
      it "returns a full name" do
        user = build(:user, :first_name => "Leonhard", :last_name => "Euler")
        expect(user.full_name).to eq("Leonhard Euler")
      end
    end

    describe "#user_languages" do
      it "returns an array of languages" do
        user = create(:user, :id => 1)
        create(:user_progress, :user_id => 1, :status => 1)
        expect(user.user_languages.first).to be_an_instance_of(Language)
      end

      it "returns only languages where the user has a current problem" do
        user = create(:user, :id => 2)
        create(:user_progress, :user_id => 2, :status => 1)
        create(:user_progress, :user_id => 2, :status => 2)
        create(:user_progress, :user_id => 2, :status => 0)
        expect(user.user_languages.count).to eq(2)
      end
    end

    describe "#available_user_languages" do
      it "returns an array of languages" do
        user = create(:user, :id => 1)
        language = create(:language)
        create(:user_progress, :user_id => 1, :status => 1)
        expect(user.available_user_languages.first).to be_an_instance_of(Language)
      end

      it "returns only languages where the user does not have a current problem" do
        user = create(:user, :id => 2)
        create(:user_progress, :user_id => 2, :status => 1)
        language = create(:language)
        expect(user.available_user_languages.first).to eq(language)
      end
    end

    describe "#completed_problems" do
      it "returns completed user_progresses (problems) for a given language" do
        user = create(:user, :id => 2)
        completed_problem = create(:user_progress, :user_id => 2, :status => 2)
        language = completed_problem.language_problem.language
        expect(user.completed_user_progresses(language)).to eq([completed_problem])
      end

      it "does not return user_progresses for incomplete problems" do
        user = create(:user, :id => 2)
        incomplete_problem = create(:user_progress, :user_id => 2, :status => 1)
        language = incomplete_problem.language_problem.language
        expect(user.completed_user_progresses(language)).to eq([])
      end

      it "does not return user_progresses for viewed problems" do
        user = create(:user, :id => 2)
        viewed_problem = create(:user_progress, :user_id => 2, :status => 0)
        language = viewed_problem.language_problem.language
        expect(user.completed_user_progresses(language)).to eq([])
      end
    end

    describe "#problems_viewed_but_not_started" do
      it "returns user_progresses (problems) that have been viewed but not started" do
        user = create(:user, :id => 2)
        viewed_problem = create(:user_progress, :user_id => 2, :status => 0)
        language = viewed_problem.language_problem.language
        expect(user.incomplete_user_progresses(language)).to eq([viewed_problem])
      end

      it "does not return the current problem" do
        user = create(:user, :id => 2)
        current_problem = create(:user_progress, :user_id => 2, :status => 1)
        language = current_problem.language_problem.language
        expect(user.incomplete_user_progresses(language)).to eq([])
      end

      it "does not return completed problems" do
        user = create(:user, :id => 2)
        completed_problem = create(:user_progress, :user_id => 2, :status => 2)
        language = completed_problem.language_problem.language
        expect(user.incomplete_user_progresses(language)).to eq([])
      end
    end

    describe "#current_problem" do
      it "returns the user's current problem for a given language" do
        user = create(:user, :id => 2)
        current_problem = create(:user_progress, :user_id => 2, :status => 1)
        language = current_problem.language_problem.language
        expect(user.current_problem(language)).to eq(current_problem.language_problem.problem)
      end

      it "returns nothing if the given language has no current problems" do
        user = create(:user, :id => 2)
        completed_problem = create(:user_progress, :user_id => 2, :status => 0)
        language = completed_problem.language_problem.language
        expect(user.current_problem(language)).to eq(nil)
      end
    end

    describe '#new_user?' do
      it 'returns true when a user is a new language user' do
        user = create(:user)
        language = create(:language)
        expect(user.new_user?(language)).to eq(true)
      end
      it 'returns false when a user is not a new language user' do
        user = create(:user)
        language = create(:language, :name => "Ruby")
        problem1 = create(:language_problem, :language => language)
        problem2 = create(:language_problem, :language => language)
        create(:user_progress, :user => user, :status => 0, :language_problem => problem1)
        create(:user_progress, :user => user, :status => 1, :language_problem => problem2)
        expect(user.new_user?(language)).to eq(false)
      end
    end
  end
end
