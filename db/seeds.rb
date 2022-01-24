# frozen_string_literal: true

require 'faker'
require './lib/constants/employees/college_degrees'

COLLEGE_DEGREES = Constants::Employees::CollegeDegrees
TOPICS = [
  'Rozpoznawanie osób na podstawie analizy obrazów',
  'Zastosowanie systemów wieloklasyfikatorowych do rozpoznawania ruchów chwytnych dłoni',
  'Porównanie wybranych narzędzi do testów aplikacji mobilnych na platformę Android',
  'Modelowanie i badanie tłumienia wtrącenia obudów dźwiękochłonno-izolacyjnych',
  'Interfejs człowiek-maszyna z wykorzystaniem rękawicy sensorycznej'
].freeze
ROLES = %i[deans_worker science_worker].freeze

College.create!(field_of_study: 'Elektronika i Telekomunikacja', faculty: 'Elektroniczny')
College.create!(field_of_study: 'Informatyka Stosowana', faculty: 'Elektroniczny')
College.create!(field_of_study: 'Automatyka i Robotyka', faculty: 'Elektroniczny')
College.create!(field_of_study: 'Prawo', faculty: 'Humanistyczny')
College.create!(field_of_study: 'Zarządzanie inżynierią produkcji', faculty: 'Humanistyczny')

StageOfStudy.create!(name: 'magisterskie')
StageOfStudy.create!(name: 'inzynierskie')
StageOfStudy.create!(name: 'doktoranckie')

first_college_index = 402_131
first_telephone_number = 123_456_789

def random_college_degree(random)
  case random
  when 0..20 then COLLEGE_DEGREES::MA
  when 20..40 then COLLEGE_DEGREES::DR
  when 40..50 then COLLEGE_DEGREES::DR_PROF
  end
end

50.times do |i|
  Student.create!(
    id: first_college_index + i,
    email: "student#{i}@email.com",
    password: 'password',
    telephone_number: (first_telephone_number + i).to_s,
    first_name: Faker::Name.unique.first_name,
    last_name: Faker::Name.unique.last_name,
    college_id: (i / 10) + 1
  )

  e = Employee.create!(
    email: "employee#{i}@email.com",
    password: 'employee_password',
    first_name: Faker::Name.unique.first_name,
    last_name: Faker::Name.unique.last_name,
    academic_degree: random_college_degree(i + 1)
  )

  e.deans_worker! if i > 25
end

50.times do |i|
  GraduationWork.create!(
    title: Faker::Quote.famous_last_words,
    topic: TOPICS[i / 10],
    date_of_submission: Faker::Date.between(from: '2014-09-23', to: '2022-02-01'),
    stage_of_study_id: (i / 20) + 1,
    supervisor_id: i + 1
  )

  ThesisDefense.create!(
    defence_address: Faker::Address.full_address,
    final_grade: Random.new.rand(2..5),
    date_of_defence: Faker::Date.between(from: '2014-09-23', to: '2022-02-01'),
    evaluator_id: i + 1,
    author_id: first_college_index + i,
    graduation_work_id: i + 1
  )
end
