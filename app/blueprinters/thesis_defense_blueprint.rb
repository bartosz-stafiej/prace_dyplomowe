# frozen_string_literal: true

class ThesisDefenseBlueprint < Blueprinter::Base
  identifier :id

  fields :author_id,
         :created_at,
         :date_of_defence,
         :defence_address,
         :evaluator_id,
         :final_grade,
         :graduation_work_id,
         :updated_at

  view :with_assoc do
    association :author, blueprint: StudentBlueprint
  end
end
