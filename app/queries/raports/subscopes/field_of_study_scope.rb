module Raports
    module Subscopes
        class FieldOfStudyScope
            def self.call(scope: GraduationWork.all, search_phrase:)
                scope
                    .joins(thesis_defenses: { author: :college })
                    .where( college: { field_of_study: search_phrase })
                    .distinct
            end
        end
    end
end