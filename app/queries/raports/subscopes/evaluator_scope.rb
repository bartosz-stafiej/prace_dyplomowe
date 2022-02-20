# frozen_string_literal: true

module Raports
  module Subscopes
    class EvaluatorScope
      def self.call(search_phrase:, scope: GraduationWork.all)
        scope
          .joins(thesis_defenses: :evaluator)
          .where(evaluator: { email: search_phrase })
          .distinct
      end
    end
  end
end
