# frozen_string_literal: true

module TokenGenerator
  class AuthorizationTokenGenerator
    def initialize(user:)
      @user = user
    end

    def call
      {
        access_token: { token: access_token, expires_in: 300 },
        refresh_token: { token: refresh_token, expires_in: 900 }
      }
    end

    private

    def access_token
      TokenGenerator::AccessTokenGenerator.new(user: user).call
    end

    def refresh_token
      TokenGenerator::RefreshTokenGenerator.new(user: user).call
    end

    attr_reader :user
  end
end
