module Raports
    module Subscopes
        class GradeScope
            def self.call(scope: GraduationWork.all, search_phrase:)
                scope
                    .joins(:thesis_defenses)
                    .where(thesis_defenses: { final_grade: search_phrase })
                    .distinct
            end
        end
    end
end