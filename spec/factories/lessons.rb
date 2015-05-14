FactoryGirl.define do
  factory :lesson do
    association :room
    association :host, factory: :user
    schedule { Faker::Date.forward }
    description { Faker::Hacker.say_something_smart }
  end

end
