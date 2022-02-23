require 'constants/users/formats'
require 'constants/reviews/grades'

module Reviews
    class CreateContract < ApplicationContract
        COMMENT_MAX_LENGTH = 3000
        EMAIL_FORMAT = Constants::Users::Formats::EMAIL_FORMAT
        GRADES = Constants::Reviews::Grades::LIST

        config.messages.namespace = 'reviews.create'

        json do
            required(:comment).filled(:string, max_size?: COMMENT_MAX_LENGTH)
            required(:date_of_issue).filled(:date_time)
            required(:grade).filled(:string, included_in?: GRADES)
            required(:reviewer_email).filled(:string, format?: EMAIL_FORMAT)
        end

        rule(:reviewer_email) do
            key.failure(:not_found, email: value) unless Employee.exists?(email: value)
        end

        rule(:date_of_issue) do
            key.failure(:invalid_date) if value > Time.zone.now
        end
    end
end