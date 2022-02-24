# frozen_string_literal: true

class ReviewPolicy < ApplicationPolicy
  def show?
    user.type == 'Employee'
  end

  def create?
    user.type == 'Employee'
  end

  def update?
    user.type == 'Employee'
  end
end
