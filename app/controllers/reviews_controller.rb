# frozen_string_literal: true

class ReviewsController < ApplicationController
  def new; end

  def create
    graduation_work = GraduationWork.find_by(id: params[:graduation_work_id])

    review = graduation_work.reviews.build(
      reviewer_id: current_employee.id,
      date_of_issue: Time.zone.now.to_date,
      **review_params
    )

    if review.save
      redirect_to graduation_works_path, notice: 'Created successfully'
    else
      redirect_back(fallback_location: :back)
      flash[:alert] = 'Validation failed'
    end
  end

  def edit
    @graduation_work = GraduationWork.find_by(id: params[:graduation_work_id])
    @review = Review.find_by(id: params[:id])
  end

  def update
    review = Review.find_by(id: params[:id])

    review.assign_attributes(review_update_params)

    if review.save
      redirect_to graduation_works_path, notice: 'Updated successfully'
    else
      redirect_back(fallback_location: :back)
      flash[:alert] = 'Validation failed'
    end
  end

  private

  def review_create_params
    params.permit(:grade, :comment)
  end

  def review_update_params
    params.require(:review).permit(:grade, :comment)
  end
end
