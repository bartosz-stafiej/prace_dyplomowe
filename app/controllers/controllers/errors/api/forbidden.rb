# frozen_string_literal: true

module Controllers
  module Errors
    module Api
      class Forbidden < BaseError
        DEFAULT_MESSAGE = I18n.t('errors.api.forbidden.default_message')
        STATUS = 403

        def initialize(message = DEFAULT_MESSAGE)
          super(message, STATUS)
        end
      end
    end
  end
end
