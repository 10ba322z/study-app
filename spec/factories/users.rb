FactoryBot.define do
  factory :user do
    username         {"tester"}
    sequence(:email) {|n| "tester#{n}@example.com"}
    password         {"tester"}
  end
end
