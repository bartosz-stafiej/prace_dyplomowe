# frozen_string_literal: true

module Api
  module V1
    class SessionsController < BaseController
      include TokenGenerator

      def create
        contract = Sessions::CreateContract.new
        validation_result = validate!(contract).to_h

        user = Sessions::Authenticator.new(
          email: validation_result[:email],
          password: validation_result[:password]
        ).call
        tokens = TokenGenerator::AuthorizationTokenGenerator.new(user: user).call

        render json: UserBlueprint.render(user, view: :with_auth, tokens: tokens, root: :user)
      end

      def refresh_token
        tokens = TokenGenerator::AuthorizationTokenGenerator.new(user: current_user).call

        render json: UserBlueprint.render(current_user, view: :with_auth, tokens: tokens, root: :user)
      end

      def destroy
        Sessions::UpdateAuthenticationToken.new(user: current_user).call

        head :no_content
      end
    end
  end
end
