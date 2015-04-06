require 'rails_helper'

RSpec.describe Language, type: :model do
  describe "Language validations" do 
    it "has a valid factory" do
      expect(create(:language)).to be_valid
    end

    it "is invalid without a name" do
      language = build(:language, :name => nil)
      expect(language).not_to be_valid
    end

    it "is invalid without a unique name" do
      language1 = create(:language, :name => "Ruby")
      language2 = build(:language, :name => "RubY")
      expect(language2).not_to be_valid
    end
  end
end
