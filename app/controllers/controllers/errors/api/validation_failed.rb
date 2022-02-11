# frozen_string_literal: true

module Controllers
    module Errors
        module Api
            class ValidationFailed < BaseError
                DEFAULT_MESSAGE = I18n.t('errors.api.validation_failed.default_message')
                DEFAULT_DETAILS = {}.freeze
                STATUS = 422

                attr_reader :details
  
                def initialize(details = DEFAULT_DETAILS)
                    super(DEFAULT_MESSAGE, STATUS)
                    @details = details
                end
            end
        end
    end
end