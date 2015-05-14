FactoryGirl.define do
  factory :room do
    association :language_problem
    title { Faker::Hacker.phrases }
  end

end
