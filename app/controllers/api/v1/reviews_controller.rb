# frozen_string_literal: true

module Api
  module V1
    class ReviewsController < BaseController
      def show
        authorize! Review

        graduation_work = GraduationWork.find(params[:graduation_work_id])

        review = graduation_work.reviews.find(params[:id])

        render json: ReviewBlueprint.render(review, view: :with_assoc, root: :review), status: :ok
      end

      def create
        authorize! Review

        graduation_work = GraduationWork.find(params[:graduation_work_id])
        contract = Reviews::CreateContract.new
        validation_result = validate!(contract)

        creator = Reviews::Create.new(data: validation_result.to_h,
                                      graduation_work: graduation_work)

        review = creator.call

        render json: ReviewBlueprint.render(review, view: :with_assoc, root: :review), status: :created
      end

      def update
        authorize! Review

        graduation_work = GraduationWork.find(params[:graduation_work_id])
        review = graduation_work.reviews.find(params[:id])
        contract = Reviews::UpdateContract.new

        validation_result = validate!(contract)

        updator = Reviews::Update.new(data: validation_result.to_h,
                                      review: review)

        updated_review = updator.call

        render json: ReviewBlueprint.render(updated_review, view: :with_assoc, root: :review), status: :ok
      end
    end
  end
end
