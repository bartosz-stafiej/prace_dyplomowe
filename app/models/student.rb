# frozen_string_literal: true

class Student < User
  belongs_to :college,
             inverse_of: :students,
             optional: true

  has_many :thesis_defenses,
           inverse_of: :author,
           dependent: :nullify

  validates_presence_of :index
end
