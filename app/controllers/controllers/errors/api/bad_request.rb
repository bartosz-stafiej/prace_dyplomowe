# frozen_string_literal: true

module Controllers
  module Errors
    module Api
      class BadRequest < BaseError
        DEFAULT_MESSAGE = I18n.t('errors.api.bad_request.default_message')
        STATUS = 400

        def initialize(message = DEFAULT_MESSAGE)
          super(message, STATUS)
        end
      end
    end
  end
end
