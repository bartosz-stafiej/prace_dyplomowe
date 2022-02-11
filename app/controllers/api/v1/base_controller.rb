# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      protect_from_forgery with: :null_session
      include ErrorsHandler

      after_action :merge_pagy_headers_if_present

      def merge_pagy_headers_if_present
        pagy_headers_merge(@pagy) if @pagy
      end

      def current_user
        return @current_user if @current_user
    
        purpose = request.url.include?('refresh_token') ? :refresh_token : :access_token
    
        @current_user = Sessions::AuthorizationTokenValidator.new(
          authorization_token: request.env['HTTP_AUTHORIZATION'],
          purpose: purpose
        ).call
      end

      def validate!(contract)
        result = contract.call(params.to_unsafe_h)

        valdation_failed!(result) if result.failure?

        result
      end
    end
  end
end
