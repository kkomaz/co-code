require 'rails_helper'

RSpec.describe Problem, type: :model do

  it "has a valid factory" do
    expect(create(:problem)).to be_valid
  end

  it "is invalid without a title" do
    problem = build(:problem, :title => nil, :slug => 'slug')
    expect(problem).not_to be_valid
  end

  it "is invalid without a content" do
    problem = build(:problem, :content => nil)
    expect(problem).not_to be_valid
  end

  it "is invalid without a difficulty" do
    problem = build(:problem, :difficulty => nil)
    expect(problem).not_to be_valid
  end

  it "is invalid with difficulty of float type" do
    problem = build(:problem, :difficulty => 1.5)
    expect(problem).not_to be_valid
  end

  it "is invalid with difficulty greater than 10" do
    problem = build(:problem, :difficulty => 11)
    expect(problem).not_to be_valid
  end

  it "is invalid with difficulty less than 1" do
    problem = build(:problem, :difficulty => 0)
    expect(problem).not_to be_valid
  end

end
