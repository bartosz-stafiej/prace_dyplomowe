# frozen_string_literal: true

module Raports
  module Subscopes
    class SupervisorScope
      # TODO: make this work
      def self.call(search_phrase:, scope: GraduationWork.all)
        scope
          .joins(:supervisor)
          .where(supervisor: { email: search_phrase })
          .distinct
      end
    end
  end
end
