# frozen_string_literal: true

module Controllers
  module Errors
    module Api
      class Conflict < BaseError
        DEFAULT_MESSAGE = I18n.t('errors.api.conflict.default_message')
        STATUS = 409

        def initialize(message = DEFAULT_MESSAGE)
          super(message, STATUS)
        end
      end
    end
  end
end
