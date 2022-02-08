# frozen_string_literal: true

module Controllers
    module Errors
        module Api
            class Unauthorized < BaseError
                DEFAULT_MESSAGE = I18n.t('errors.api.unauthorized.default_message')
                STATUS = 401
  
                def initialize(message = DEFAULT_MESSAGE)
                    super(message, STATUS)
                end
            end
        end
    end
end