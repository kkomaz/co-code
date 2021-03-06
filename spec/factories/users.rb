FactoryGirl.define do

  factory :user, aliases: [:host] do
    email {Faker::Internet.email}
    password {Faker::Internet.password}
    password_confirmation { |u| u.password }
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}

  end
end
