# frozen_string_literal: true

class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  has_many :graduation_works,
           inverse_of: :supervisor,
           dependent: :nullify

  has_many :college,
           inverse_of: :supervisor,
           dependent: :nullify

  has_many :thesis_defenses,
           inverse_of: :evaluator,
           dependent: :nullify
end
