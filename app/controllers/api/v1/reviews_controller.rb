module Api
    module V1
        class ReviewsController < BaseController
          def create
            authorize! Review

            graduation_work = GraduationWork.find(params[:graduation_work_id])
            contract = Reviews::CreateContract.new
            validation_result = validate!(contract)

            creator = Reviews::Create.new(data: validation_result.to_h,
                                          graduation_work: graduation_work)

            review = creator.call

            render json: ReviewBlueprint.render(review, view: :with_assoc, root: :review)
          end
        end
    end
end