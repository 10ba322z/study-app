FactoryBot.define do
  pass = Faker::Internet.password(8)
  factory :user, aliases: [:owner] do
    username  {Faker::Name.name}
    email     {Faker::Internet.email}
    password  {pass}
  end
end
