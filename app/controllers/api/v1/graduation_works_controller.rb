# frozen_string_literal: true

module Api
  module V1
    class GraduationWorksController < BaseController
      def index
        scope = GraduationWork.all
        filtered_scope = GraduationWorks::SearchByTitleQuery
                         .new(
                           scope: scope,
                           search_phrase: params[:search_phrase]
                         ).call

        @pagy, @graduation_works = pagy(filtered_scope, items: params[:items])

        render json: GraduationWorkBlueprint.render(@graduation_works, root: :graduation_works)
      end

      def show; end
    end
  end
end
