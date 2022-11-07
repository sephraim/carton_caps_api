# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    birthdate { Faker::Date.birthday(min_age: 18, max_age: 90) }
    zip_code { Faker::Number.number(digits: 5) }
    referral_code { Faker::Alphanumeric.alphanumeric(number: 6).upcase }
  end
end
