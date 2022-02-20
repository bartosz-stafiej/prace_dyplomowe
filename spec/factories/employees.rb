# frozen_string_literal: true

require 'constants/users/academic_degrees'

DR_PROFESOR = Constants::Users::AcademicDegrees::DR_PROF

FactoryBot.define do
  factory :employee do
    academic_degree { DR_PROFESOR }
    first_name { Faker::Name.unique.first_name }
    last_name { Faker::Name.unique.last_name }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    authentication_token { Random.hex(60) }
  end
end
