module Raports
    module Subscopes
        class KeyWordScope
            def self.call(scope: GraduationWork.all, search_phrase:)
                scope
            end 
        end
    end
end