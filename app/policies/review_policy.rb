class ReviewPolicy < ApplicationPolicy
    def create?
        user.type === 'Employee'
    end
end