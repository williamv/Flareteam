# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organization do
    name { Faker::Company.name }
    street_address { Faker::Address.street_address }
    city { Faker::AddressUS.city }
    state { Faker::AddressUS.state_abbr }
    zip_code { Faker::AddressUS.zip_code }
    phone { Faker::PhoneNumber.phone_number }
    primary_contact_name { Faker::Name.name }
    primary_contact_phone { Faker::PhoneNumber.phone_number }
    primary_contact_email { Faker::Internet.email }
    emergency_role { Faker::Lorem.sentence }
    employee_count_range "1-10"
  end
end
