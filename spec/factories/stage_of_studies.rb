# frozen_string_literal: true

FactoryBot.define do
  factory :stage_of_study do
    name { 'inzynierskie' }

    factory :magisterskie do
      name { 'magisterskie' }
    end

    factory :doktoranckie do
      name { 'doktoranckie' }
    end

    factory :inzynierskie do
      name { 'inzynierskie' }
    end
  end
end
