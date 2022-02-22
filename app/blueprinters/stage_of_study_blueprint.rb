# frozen_string_literal: true

class StageOfStudyBlueprint < Blueprinter::Base
  identifier :id

  fields :name,
         :created_at,
         :updated_at
end
