# frozen_string_literal: true

class GraduationWorkBlueprint < Blueprinter::Base
  identifier :id

  fields :title,
         :topic,
         :date_of_submission

  view :with_assoc do
    association :stage_of_study, blueprint: StageOfStudyBlueprint
    association :supervisor, blueprint: EmployeeBlueprint
  end
end
