require 'faker'

FactoryBot.define do
    factory :student do
        index { 4021342 }
        email { Faker::Internet.email }
        password { 'password' }
        telephone_number { '123456789' }
        first_name { Faker::Name.unique.first_name }
        last_name { Faker::Name.unique.last_name }

        association :college, factory: :college
    end
end