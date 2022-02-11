module Sessions
    class UpdateAuthenticationToken
        def initialize(user:)
            @user = user
        end

        def call
            user.update(authentication_token: authentication_token)
        end

        private

        def authentication_token
            TokenGenerator::AuthenticationTokenGenerator.call
        end

        attr_reader :user
    end
end