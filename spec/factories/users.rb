FactoryBot.define do
  factory :user do
    name { Faker::Creature::Dog.name }
    email  { Faker::Internet.email }
    bio  { Faker::Movies::Ghostbusters.quote }
    username  { Faker::DrivingLicence.uk_driving_licence }
    image  { 'https://i.kym-cdn.com/photos/images/newsfeed/001/076/734/879.jpg' }
  end
end
