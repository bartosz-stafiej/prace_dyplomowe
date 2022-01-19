# frozen_string_literal: true

class College < ApplicationRecord
  has_many :students,
           inverse_of: :college,
           dependent: :delete_all
end
