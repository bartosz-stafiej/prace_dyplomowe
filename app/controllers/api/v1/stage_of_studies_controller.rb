# frozen_string_literal: true

module Api
  module V1
    class StageOfStudiesController < BaseController
      def index
        render json: StageOfStudyBlueprint.render(
          StageOfStudy.all,
          root: :stage_of_studies
        ), status: :ok
      end
    end
  end
end
