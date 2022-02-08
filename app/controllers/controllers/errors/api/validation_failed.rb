# frozen_string_literal: true

module Controllers
    module Errors
        module Api
            class ValidationFailed < BaseError
                DEFAULT_MESSAGE = I18n.t('errors.api.validation_failed.default_message')
                STATUS = 422
  
                def initialize(message = DEFAULT_MESSAGE)
                    super(message, STATUS)
                end
            end
        end
    end
end