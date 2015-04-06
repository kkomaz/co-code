FactoryGirl.define do

  factory :problem do
    title {Faker::Lorem.word}
    content {Faker::Lorem.paragraph}
    difficulty {rand(1..10)}
  end

end
