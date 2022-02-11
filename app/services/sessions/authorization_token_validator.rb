module Sessions
    class AuthorizationTokenValidator
        def initialize(authorization_token:, purpose:)
            @authorization_token = authorization_token
            @purpose = purpose
        end

        def call
            raise Controllers::Errors::Api::Unauthorized unless valid_auth?

            current_user
        end

        private

        def valid_auth?
            current_user &&
                current_user.authentication_token == data[:authentication_token]
        end

        def data
            @data ||= TokenGenerator::MessageVerifier.decode(
                message: authorization_token,
                purpose: purpose
            )
        end

        def current_user
            @current_user ||= User.find(data[:user_id])
        end

        attr_reader :authorization_token, :purpose
    end
end