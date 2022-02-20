# frozen_string_literal: true

module Raports
  module Subscopes
    class DateRangeScope
      def self.call(search_phrase:, scope: GraduationWork.all)
        scope.where(date_of_submission: search_phrase)
      end
    end
  end
end
