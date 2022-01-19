# frozen_string_literal: true

class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :college,
             inverse_of: :students,
             optional: true

  has_many :thesis_defenses,
           inverse_of: :author,
           dependent: :nullify
end
