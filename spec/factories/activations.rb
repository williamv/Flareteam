# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activation do
    title { Faker::Company.bs }
    location { Faker::Address.city }
    description { Faker::Lorem.paragraph }

    association :user
  end
end
