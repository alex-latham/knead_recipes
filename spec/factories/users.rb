FactoryBot.define do
  factory :user do
    name { Faker::Creature::Dog.name }
    email  { Faker::Internet.email }
    bio  { Faker::Movies::Ghostbusters.quote }
    username  { Faker::DrivingLicence.uk_driving_licence }
  end
end
