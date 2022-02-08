# frozen_string_literal: true

class EmployeeBlueprint < Blueprinter::Base
  identifier :id

  fields :academic_degree,
         :first_name,
         :last_name,
         :type,
         :email
end
