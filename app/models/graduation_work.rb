# frozen_string_literal: true

class GraduationWork < ApplicationRecord
  belongs_to :stage_of_study,
             inverse_of: :graduation_works

  belongs_to :supervisor,
             class_name: :Employee,
             inverse_of: :graduation_works

  has_many :thesis_defenses,
           inverse_of: :graduation_work,
           dependent: :delete_all
end
