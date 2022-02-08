require 'faker'

FactoryBot.define do
    factory :review do
        date_of_issue { Faker::Date.between(from: '2014-09-23', to: '2022-02-01') }
        grade { Random.new.rand(2..5).to_f }
        comment { 'quite bad' }

        association :graduation_work, factory: :graduation_work
        association :reviewer, factory: :employee
    end
end