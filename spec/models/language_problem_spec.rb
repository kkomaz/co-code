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
end
