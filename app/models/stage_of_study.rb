# frozen_string_literal: true

class StageOfStudy < ApplicationRecord
  has_many :graduation_works,
           inverse_of: :stage_of_study,
           dependent: :nullify
end
