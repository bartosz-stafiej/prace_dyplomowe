module Raports
    module Subscopes
        class DateRangeScope
            def self.call(scope: GraduationWork.all, search_phrase:)
                scope.where(date_of_submission: search_phrase)
            end
        end
    end
end