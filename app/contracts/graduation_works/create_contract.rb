# frozen_string_literal: true

require 'constants/users/formats'

module GraduationWorks
  class CreateContract < ApplicationContract
    TITLE_MAX_LENGTH = 100
    TOPIC_MAX_LENGTH = 100
    EMAIL_FORMAT = Constants::Users::Formats::EMAIL_FORMAT

    config.messages.namespace = 'graduation_works.create'

    json do
      required(:title).filled(:string, max_size?: TITLE_MAX_LENGTH)
      required(:topic).filled(:string, max_size?: TOPIC_MAX_LENGTH)
      required(:date_of_submission).filled(:date_time)
      required(:stage_of_study_id).filled(:integer, gt?: 0)
      required(:supervisor_email).filled(:string, format?: EMAIL_FORMAT)
    end

    rule(:date_of_submission) do
      key.failure(:invalid_date) if value > Time.zone.now
    end

    rule(:supervisor_email) do
      key.failure(:not_found, email: value) unless Employee.exists?(email: value)
    end

    rule(:stage_of_study_id) do
      key.failure(:not_found, id: value) unless StageOfStudy.exists?(value)
    end
  end
end
