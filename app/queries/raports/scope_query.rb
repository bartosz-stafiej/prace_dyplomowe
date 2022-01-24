# frozen_string_literal: true

module Raports
  class ScopeQuery
    def initialize(search_params:)
      @search_params = search_params
    end

    def call
      GraduationWork.joins(:thesis_defenses).where(
        thesis_defenses: { final_grade: search_params[:grade] }
      ).distinct
    end

    private

    attr_reader :search_params
  end
end
