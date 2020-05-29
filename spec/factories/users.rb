FactoryBot.define do
  factory :user do
    name { Faker::Creature::Dog.name }
    email  { Faker::Internet.email }
    bio  { Faker::Movies::Ghostbusters.quote }
  end
end
