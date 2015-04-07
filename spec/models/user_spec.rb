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

  context "User instance methods" do 
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

    describe "#find_language_problem_ids" do
      it "returns language_problem_ids belonging to a user" do
        # user = create(:user, :id => 1)
        
        # create()
      end


    end


  end
end
