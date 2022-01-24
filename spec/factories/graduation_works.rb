# frozen_string_literal: true

require 'faker'

TOPICS = %w[
  Rozpoznawanie osób na podstawie analizy obrazów
  Zastosowanie systemów wieloklasyfikatorowych do rozpoznawania ruchów chwytnych dłoni
  Porównanie wybranych narzędzi do testów aplikacji mobilnych na platformę Android
  Modelowanie i badanie tłumienia wtrącenia obudów dźwiękochłonno-izolacyjnych
  Interfejs człowiek-maszyna z wykorzystaniem rękawicy sensorycznej
].freeze

FactoryBot.define do
  factory :graduation_work do
    title { Faker::Quote.famous_last_words }
    topic { TOPICS[Random.new.rand(20..30)] }
    date_of_submission { Faker::Date.between(from: '2014-09-23', to: '2022-02-01') }

    association :stage_of_study
    association :supervisor, factory: :employee
  end
end
