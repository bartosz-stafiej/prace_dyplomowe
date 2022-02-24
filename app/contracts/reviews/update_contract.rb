# frozen_string_literal: true

require 'constants/users/formats'
require 'constants/reviews/grades'

module Reviews
  class UpdateContract < ApplicationContract
    COMMENT_MAX_LENGTH = 3000
    EMAIL_FORMAT = Constants::Users::Formats::EMAIL_FORMAT
    GRADES = Constants::Reviews::Grades::LIST

    config.messages.namespace = 'reviews.update'

    json do
      optional(:comment).filled(:string, max_size?: COMMENT_MAX_LENGTH)
      optional(:date_of_issue).filled(:date_time)
      optional(:grade).filled(:string, included_in?: GRADES)
      optional(:reviewer_email).filled(:string, format?: EMAIL_FORMAT)
    end

    rule(:reviewer_email) do
      next unless value

      key.failure(:not_found, email: value) unless Employee.exists?(email: value)
    end

    rule(:date_of_issue) do
      next unless value

      key.failure(:invalid_date) if value > Time.zone.now
    end
  end
end
