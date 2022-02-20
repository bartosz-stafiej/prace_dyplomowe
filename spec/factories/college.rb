# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :college do
    field_of_study { 'Elektronika i Telekomunikacja' }
    faculty { 'Elektroniczny' }
  end
end
