module Raports
    module Subscopes
        class FacultyScope
            def self.call(scope: GraduationWork.all, search_phrase:)
                scope
                    .joins(thesis_defenses: { author: :college })
                    .where( college: { faculty: search_phrase })
                    .distinct
            end
        end
    end
end