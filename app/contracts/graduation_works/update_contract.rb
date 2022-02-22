# frozen_string_literal: true

require 'constants/users/formats'

module GraduationWorks
  class UpdateContract < ApplicationContract
    TITLE_MAX_LENGTH = 100
    TOPIC_MAX_LENGTH = 100
    EMAIL_FORMAT = Constants::Users::Formats::EMAIL_FORMAT

    config.messages.namespace = 'graduation_works.update'

    json do
      optional(:title).filled(:string, max_size?: TITLE_MAX_LENGTH)
      optional(:topic).filled(:string, max_size?: TOPIC_MAX_LENGTH)
      optional(:date_of_submission).filled(:date_time)
      optional(:stage_of_study_id).filled(:integer, gt?: 0)
      optional(:supervisor_email).filled(:string, format?: EMAIL_FORMAT)
    end

    rule(:date_of_submission) do
      next unless value

      key.failure(:invalid_date) if value > Time.zone.now
    end

    rule(:supervisor_email) do
      next unless value

      key.failure(:not_found, email: value) unless Employee.exists?(email: value)
    end

    rule(:stage_of_study_id) do
      next unless value

      key.failure(:not_found, id: value) unless StageOfStudy.exists?(value)
    end
  end
end
