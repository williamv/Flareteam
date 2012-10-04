# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { "Wow, this password is really very secure!" }
    emergency_role { Faker::Lorem.words(10) }
    mobile_phone_number { Faker::PhoneNumber.phone_number }
    landline_phone_number { Faker::PhoneNumber.phone_number }

    association :organization
  end
end
