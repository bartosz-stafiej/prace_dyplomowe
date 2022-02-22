# frozen_string_literal: true

class GraduationWorkPolicy < ApplicationPolicy
  scope_for :active_record_relation, :owner do |relation|
    case user.type
    when 'Student'
      relation.joins(:thesis_defenses)
              .where(thesis_defenses: { author_id: user.id })
    when 'Employee'
      relation.where(supervisor_id: user.id)
    end
  end

  def create?
    user.type == 'Employee'
  end

  def update?
    user.type == 'Employee'
  end
end
