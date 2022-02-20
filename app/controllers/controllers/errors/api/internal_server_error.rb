# frozen_string_literal: true

module Controllers
  module Errors
    module Api
      class InternalServerError < BaseError
        DEFAULT_MESSAGE = I18n.t('errors.api.internal_server_error.default_message')
        STATUS = 500

        def initialize(message = DEFAULT_MESSAGE)
          super(message, STATUS)
        end
      end
    end
  end
end
