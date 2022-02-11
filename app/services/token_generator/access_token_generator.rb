
module TokenGenerator
    class AccessTokenGenerator
        def initialize(user:)
            @user = user
        end

        def call
            data = { user_id: user.id, authentication_token: user.authentication_token }

            MessageVerifier.encode(data: data, expires_at: Time.now + 300, purpose: :access_token)
        end

        private

        attr_reader :user
    end
end