# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :thesis_defense do
    date_of_defence { Faker::Date.between(from: '2014-09-23', to: '2022-02-01') }
    final_grade { Random.new.rand(2..5).to_f }
    defence_address { Faker::Address.full_address }

    association :evaluator, factory: :employee
    association :author, factory: :student
    association :graduation_work, factory: :graduation_work
  end
end
