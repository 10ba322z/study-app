FactoryBot.define do
  factory :micropost do
    content  {"test content"}
    start_at {"Time.zone.now -2.hour"}
    end_at   {"Time.zone.now"}
    association :user
  end
end
