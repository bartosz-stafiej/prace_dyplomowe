# frozen_string_literal: true

module Constatns
  module GraduationWorks
    module CsvAttrs
      CSV_ATTRS = [
        {
          attrs: %w[id title topic date_of_submission],
          first: :itself,
          name: :itself
        },
        {
          attrs: %w[grade comment],
          first: :first,
          name: :reviews
        },
        {
          attrs: ['name'],
          first: :itself,
          name: :stage_of_study
        },
        {
          attrs: %w[defence_address final_grade date_of_defence author_id],
          first: :first,
          name: :thesis_defenses
        },
        {
          attrs: %w[academic_degree first_name last_name email],
          first: :itself,
          name: :supervisor
        }
      ].freeze
    end
  end
end
