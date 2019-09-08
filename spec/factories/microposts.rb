FactoryBot.define do
  factory :micropost do
    sequence(:content) { |n| "test content#{n}" }
    start_at {Time.zone.now - 2.hour}
    end_at   {Time.zone.now}
    association :user
  end
end
