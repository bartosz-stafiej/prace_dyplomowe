# frozen_string_literal: true

class GraduationWorksController < ApplicationController
  include Pagy::Backend
  include ApplicationHelper

  before_action :authenticate_employee!, except: %i[show index]

  def new; end

  def create
    supervisor_id = params[:employee_email].nil? ? current_employee.id : Employee.find_by(email: params[:employee_email])&.id
    raise ActiveRecord::RecordNotFound if supervisor_id.nil?

    gd = GraduationWork.new(
      supervisor_id: supervisor_id,
      **graduation_work_create_params
    )

    if gd.save
      redirect_to graduation_works_path, notice: 'Created successfully'
    else
      redirect_back(fallback_location: :back)
      flash[:alert] = 'Validation failed'
    end
  rescue ActiveRecord::RecordNotFound
    redirect_back(fallback_location: :back)
    flash[:alert] = 'Did not found supervisor'
  end

  def index
    scope = me? ? my_graduation_works : GraduationWork.all
    filtered_scope = GraduationWorks::SearchByTitleQuery
                     .new(
                       scope: scope,
                       search_phrase: params[:search_phrase]
                     ).call

    @pagy, @graduation_works = pagy(filtered_scope, items: params[:items])
  end

  def show
    @graduation_work = GraduationWork.find_by(id: params[:id])
    @reviews = @graduation_work.reviews
    @thesis_defences = @graduation_work.thesis_defenses
  end

  def edit
    @graduation_work = GraduationWork.find_by(id: params[:id])
  end

  def update
    graduation_work = GraduationWork.find_by(id: params[:id])

    graduation_work.assign_attributes(graduation_work_update_params)

    if graduation_work.save
      redirect_to graduation_works_path, notice: 'Updated successfully'
    else
      redirect_back(fallback_location: :back)
      flash[:alert] = 'Validation failed'
    end
  end

  private

  def graduation_work_create_params
    params.permit(:title, :topic, :date_of_submission, :stage_of_study_id)
  end

  def graduation_work_update_params
    params.require(:graduation_work).permit(:title, :topic, :date_of_submission, :stage_of_study_id)
  end

  def my_graduation_works
    if current_resource_student?
      GraduationWork.joins(:thesis_defenses)
                    .where(thesis_defenses: { author_id: current_student.id })
    else
      GraduationWork.where(supervisor_id: current_employee.id)
    end
  end
end
