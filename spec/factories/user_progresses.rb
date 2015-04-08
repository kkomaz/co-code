FactoryGirl.define do
  factory :user_progress do
    user
    language_problem
    status {rand(0..2)}
    favorite {[true,false].sample}
  end
end
