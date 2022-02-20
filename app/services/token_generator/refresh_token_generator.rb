# frozen_string_literal: true

module TokenGenerator
  class RefreshTokenGenerator
    def initialize(user:)
      @user = user
    end

    def call
      data = { user_id: user.id, authentication_token: user.authentication_token }

      MessageVerifier.encode(data: data, expires_at: Time.zone.now + 900, purpose: :refresh_token)
    end

    private

    attr_reader :user
  end
end
