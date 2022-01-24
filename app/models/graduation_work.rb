# frozen_string_literal: true

require 'constants/graduation_works/csv_attrs'
require 'csv'

class GraduationWork < ApplicationRecord
  CSV_ATTRS = Constatns::GraduationWorks::CsvAttrs::CSV_ATTRS

  belongs_to :stage_of_study,
             inverse_of: :graduation_works

  belongs_to :supervisor,
             class_name: :Employee,
             inverse_of: :graduation_works

  has_many :thesis_defenses,
           inverse_of: :graduation_work,
           dependent: :delete_all

  has_many :reviews,
           inverse_of: :graduation_work,
           dependent: :delete_all

  has_many :key_words,
           inverse_of: :graduation_work,
           dependent: :nullify

  validates :title, :topic, :date_of_submission, presence: true

  def self.generate_csv(scope)
    CsvGeneratorWorker.new.perform(scope)
  end

  def self.to_csv(scope)
    CSV.generate(headers: true) do |csv|
      csv << CSV_ATTRS.pluck(:attrs).flatten

      scope.each do |gd|
        csv << CSV_ATTRS.map do |hash|
          hash[:attrs].map { |attr| gd.send(hash[:name])&.send(hash[:first])&.send(attr) }
        end.flatten
      end
    end
  end
end
