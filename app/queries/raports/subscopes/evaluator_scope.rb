module Raports
    module Subscopes
        class EvaluatorScope
            def self.call(scope: GraduationWork.all, search_phrase:)
                scope
                    .joins(thesis_defenses: :evaluator)
                    .where(evaluator: { email: search_phrase } )
                    .distinct
            end
        end
    end
end