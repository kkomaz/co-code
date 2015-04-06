FactoryGirl.define do
  factory :post do
    title {Faker::Lorem.word}
    content {Faker::Lorem.paragraph}
    language_problem
    user
  end

end
