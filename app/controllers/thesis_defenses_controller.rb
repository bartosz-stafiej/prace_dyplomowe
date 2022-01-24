# frozen_string_literal: true

class ThesisDefensesController < ApplicationController
  before_action :authenticate_employee!

  def new; end

  def create
    evaluator_id = Employee.find_by(email: params[:evaluator_email])&.id
    raise ActiveRecord::RecordNotFound, 'Cannot find employee' if evaluator_id.nil?

    author_id = Student.find_by(id: params[:author_index])&.id
    raise ActiveRecord::RecordNotFound, 'Cannot find author' if author_id.nil?

    gd = GraduationWork.find_by(id: params[:graduation_work_id])

    thesis_defense = ThesisDefense.new(
      graduation_work_id: gd.id,
      author_id: author_id,
      evaluator_id: evaluator_id,
      **thesis_defense_create_params
    )

    if thesis_defense.save
      redirect_to graduation_works_path, notice: 'Created successfully'
    else
      redirect_back(fallback_location: :back)
      flash[:alert] = 'Validation failed'
    end
  rescue ActiveRecord::RecordNotFound => e
    redirect_back(fallback_location: :back)
    flash[:alert] = e.message
  end

  def edit
    @graduation_work = GraduationWork.find_by(id: params[:graduation_work_id])
    @thesis_defense = ThesisDefense.find_by(id: params[:id])
  end

  def update
    if params[:evaluator_email]
      evaluator_id = Employee.find_by(email: params[:evaluator_email])&.id
      raise ActiveRecord::RecordNotFound, 'Cannot find employee' if evaluator_id.nil?
    end

    if params[:author_index]
      author_id = Student.find_by(id: params[:author_index])&.id
      raise ActiveRecord::RecordNotFound, 'Cannot find author' if author_id.nil?
    end

    thesis_defense = ThesisDefense.find_by(id: params[:id])

    thesis_defense.assign_attributes(thesis_defense_update_params)

    if thesis_defense.save
      redirect_to graduation_works_path, notice: 'Updated successfully'
    else
      redirect_back(fallback_location: :back)
      flash[:alert] = 'Validation failed'
    end
  rescue ActiveRecord::RecordNotFound => e
    redirect_back(fallback_location: :back)
    flash[:alert] = e.message
  end

  private

  def thesis_defense_create_params
    params.permit(:defence_address, :final_grade, :date_of_defence)
  end

  def thesis_defense_update_params
    params.require(:thesis_defense).permit(:defence_address, :final_grade, :date_of_defence)
  end
end
