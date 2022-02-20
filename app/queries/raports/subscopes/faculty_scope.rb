# frozen_string_literal: true

module Raports
  module Subscopes
    class FacultyScope
      def self.call(search_phrase:, scope: GraduationWork.all)
        scope
          .joins(thesis_defenses: { author: :college })
          .where(college: { faculty: search_phrase })
          .distinct
      end
    end
  end
end
