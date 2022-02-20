# frozen_string_literal: true

class Student < User
  belongs_to :college,
             inverse_of: :students,
             optional: true

  has_many :thesis_defenses,
           inverse_of: :author,
           dependent: :nullify

  validates :index, presence: true
end
