# frozen_string_literal: true

class ThesisDefense < ApplicationRecord
  belongs_to :evaluator,
             class_name: :Employee,
             inverse_of: :thesis_defenses

  belongs_to :author,
             class_name: :Student,
             inverse_of: :thesis_defenses

  belongs_to :graduation_work,
             inverse_of: :thesis_defenses
end
