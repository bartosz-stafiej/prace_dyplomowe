# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def current_resource_student?
    current_resource.instance_of?(Student)
  end

  def current_resource_edit_profile_path
    if current_resource_student?
      student_registration_path(current_student)
    else
      employee_registration_path(current_employee)
    end
  end

  def current_deans_worker?
    !current_student && current_resource&.deans_worker?
  end

  def current_science_worker?
    !current_resource_student? && current_resource&.science_worker?
  end

  def current_resource
    current_student || current_employee
  end
end
