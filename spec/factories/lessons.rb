FactoryGirl.define do
  factory :lesson do
    room
    host
    schedule { Faker::Date.forward }
    description { Faker::Hacker.say_something_smart }
  end

end
