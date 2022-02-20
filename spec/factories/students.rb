# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :student do
    index { 4_021_342 }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    telephone_number { '123456789' }
    first_name { Faker::Name.unique.first_name }
    last_name { Faker::Name.unique.last_name }
    authentication_token { Random.hex(60) }

    association :college, factory: :college
  end
end
