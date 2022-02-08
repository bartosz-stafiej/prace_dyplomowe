# frozen_string_literal: true

class GraduationWorkBlueprint < Blueprinter::Base
  identifier :id

  fields :created_at,
         :date_of_submission,
         :title,
         :topic,
         :date_of_submission,
         :updated_at

  view :with_assoc do
    association :thesis_defenses, blueprint: ThesisDefenseBlueprint, view: :with_assoc
    association :supervisor, blueprint: EmployeeBlueprint
    association :reviews, blueprint: ReviewBlueprint, view: :with_assoc
  end
end
