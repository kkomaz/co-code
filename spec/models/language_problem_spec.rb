require 'rails_helper'

RSpec.describe LanguageProblem, type: :model do
  describe "LanguageProblem validations" do 
    it "has a valid factory" do
      expect(create(:language_problem)).to be_valid
    end

    it "is invalid without language id" do
      language_problem = build(:language_problem, :language => nil)
      expect(language_problem).not_to be_valid
    end

    it "is invalid without a problem id" do
      language_problem = build(:language_problem, :problem => nil)
      expect(language_problem).not_to be_valid
    end
  end

  describe "Language helper method test" do
    before(:each) do
      @language = create(:language, :id => 1)
      @language_problem_1 = create(:language_problem, :language_id => 1, :problem_id => 1)
      @language_problem_2 = create(:language_problem, :language_id => 1, :problem_id => 2)
    end

    it "returns the CORRECT language_problem object" do
      language_problem_finder = LanguageProblem.find_language_problem(@language_problem_1.problem_id)
      expect(language_problem_finder).to eq(@language_problem_1)
    end

    it "returns the WRONG language_problem object" do
      language_problem_finder = LanguageProblem.find_language_problem(@language_problem_1.problem_id)
      expect(language_problem_finder).not_to eq(@language_problem_2)
    end
  end
end
