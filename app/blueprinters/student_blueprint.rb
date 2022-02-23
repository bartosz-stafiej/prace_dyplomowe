# frozen_string_literal: true

class StudentBlueprint < Blueprinter::Base
  identifier :id

  fields :created_at,
         :college_id,
         :email,
         :first_name,
         :index,
         :last_name,
         :telephone_number,
         :type,
         :updated_at
end
