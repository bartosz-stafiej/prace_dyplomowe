# frozen_string_literal: true

module Sessions
    class CreateContract < ApplicationContract
        EMAIL_FORMAT = /\A[^@\s]+@[^@\s]+\z/.freeze
        PASSWORD_MAX_LENGTH = 50
  
        config.messages.namespace = 'sessions.create'

        json do
            required(:email).filled(:string, format?: EMAIL_FORMAT)
            required(:password).filled(:string, max_size?: PASSWORD_MAX_LENGTH)
        end
    end
end