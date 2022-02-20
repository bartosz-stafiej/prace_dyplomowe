# frozen_string_literal: true

module Raports
  module Subscopes
    class GradeScope
      def self.call(search_phrase:, scope: GraduationWork.all)
        scope
          .joins(:thesis_defenses)
          .where(thesis_defenses: { final_grade: search_phrase })
          .distinct
      end
    end
  end
end
