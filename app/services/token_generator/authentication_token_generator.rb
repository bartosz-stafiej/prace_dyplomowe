# frozen_string_literal: true

module TokenGenerator
  module AuthenticationTokenGenerator
    def self.call
      loop do
        token = SecureRandom.hex(60)
        break token unless User.where(authentication_token: token).any?
      end
    end
  end
end
