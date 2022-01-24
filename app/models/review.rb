# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :reviewer,
             class_name: :Employee,
             inverse_of: :reviews

  belongs_to :graduation_work,
             inverse_of: :reviews

  validates :grade, :comment, presence: true
end
