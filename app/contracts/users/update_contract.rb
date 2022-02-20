# frozen_string_literal: true

require 'constants/users/formats'
require 'constants/users/academic_degrees'

module Users
  class UpdateContract < ApplicationContract
    EMAIL_FORMAT = Constants::Users::Formats::EMAIL_FORMAT
    TELEPHONE_FORMAT = Constants::Users::Formats::TELEPHONE_FORMAT
    NAME_MAX_LENGTH = 60
    ACADEMIC_DEGREES = Constants::Users::AcademicDegrees::LIST

    config.messages.namespace = 'users.update'

    json do
      optional(:email).filled(:string, format?: EMAIL_FORMAT)
      optional(:first_name).filled(:string, max_size?: NAME_MAX_LENGTH)
      optional(:last_name).filled(:string, max_size?: NAME_MAX_LENGTH)
      optional(:academic_degree).filled(:string, included_in?: ACADEMIC_DEGREES)
      optional(:telephone_number).filled(:string, format?: TELEPHONE_FORMAT)
    end

    rule(:email) do
      key.failure(:taken) if User.exists?(email: value)
    end
  end
end
