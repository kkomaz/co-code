FactoryGirl.define do
  factory :invitation do
    association :lesson
    association :user
  end
end
