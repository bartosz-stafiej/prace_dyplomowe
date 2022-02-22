# frozen_string_literal: true

module Api
  module V1
    class GraduationWorksController < BaseController
      include Pagy::Backend

      def index
        scope = me? ? authorized_scope(GraduationWork.all, as: :owner) : GraduationWork.all

        filtered_scope = GraduationWorks::SearchByTitleQuery
                         .new(
                           scope: scope,
                           search_phrase: params[:search_phrase]
                         ).call

        @pagy, graduation_works = pagy(filtered_scope, items: params[:items])

        render json: GraduationWorkBlueprint.render(graduation_works, root: :graduation_works,
                                                                      meta: { item_count: filtered_scope.count })
      end

      def show
        graduation_work = GraduationWork.find(params[:id])

        render json: GraduationWorkBlueprint.render(graduation_work, view: :with_assoc, root: :graduation_work)
      end

      def create
        authorize! GraduationWork

        contract = GraduationWorks::CreateContract.new
        validation_result = validate!(contract)

        creator = GraduationWorks::Create.new(data: validation_result.to_h)

        graduation_work = creator.call

        render json: GraduationWorkBlueprint.render(graduation_work, view: :with_assoc, root: :graduation_work),
               status: :created
      end

      def update
        authorize! GraduationWork

        graduation_work = GraduationWork.find(params[:id])

        contract = GraduationWorks::UpdateContract.new
        validation_result = validate!(contract)

        updator = GraduationWorks::Update.new(data: validation_result.to_h,
                                              graduation_work: graduation_work)

        updated_graduation_work = updator.call

        render json: GraduationWorkBlueprint.render(updated_graduation_work, view: :with_assoc, root: :graduation_work),
               status: :ok
      end
    end
  end
end
