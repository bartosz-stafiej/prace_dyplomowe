# frozen_string_literal: true

module Raports
  module Subscopes
    class FieldOfStudyScope
      def self.call(search_phrase:, scope: GraduationWork.all)
        scope
          .joins(thesis_defenses: { author: :college })
          .where(college: { field_of_study: search_phrase })
          .distinct
      end
    end
  end
end
