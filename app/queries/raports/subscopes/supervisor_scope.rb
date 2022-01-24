module Raports
    module Subscopes
        class SupervisorScope
            def self.call(scope: GraduationWork.all, search_phrase:)
                scope
                    .joins(:supervisor)
                    .where(supervisor: { email: 'employee0@email.com' })
                    .distinct
            end
        end
    end
end