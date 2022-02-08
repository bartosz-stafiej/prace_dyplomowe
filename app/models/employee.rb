# frozen_string_literal: true

class Employee < User
  enum role: { deans_worker: 0, science_worker: 1 }

  after_create :set_default_role

  has_many :graduation_works,
           inverse_of: :supervisor,
           dependent: :nullify

  has_many :college,
           inverse_of: :supervisor,
           dependent: :nullify

  has_many :thesis_defenses,
           inverse_of: :evaluator,
           dependent: :nullify

  has_many :reviews,
           inverse_of: :reviewer,
           dependent: :nullify

  private

  def set_default_role
    science_worker!
  end
end
