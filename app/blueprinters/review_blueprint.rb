# frozen_string_literal: true

class ReviewBlueprint < Blueprinter::Base
  identifier :id

  fields :comment,
         :created_at,
         :date_of_issue,
         :grade,
         :updated_at

  view :with_assoc do
    association :reviewer, blueprint: EmployeeBlueprint
  end
end
