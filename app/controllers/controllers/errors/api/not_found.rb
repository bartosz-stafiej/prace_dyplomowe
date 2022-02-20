# frozen_string_literal: true

module Controllers
  module Errors
    module Api
      class NotFound < BaseError
        DEFAULT_MESSAGE = I18n.t('errors.api.not_found.default_message')
        STATUS = 404

        def initialize(message = DEFAULT_MESSAGE)
          super(message, STATUS)
        end
      end
    end
  end
end
