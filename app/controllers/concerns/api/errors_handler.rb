# frozen_string_literal: true

module Api
  module ErrorsHandler
    extend ActiveSupport::Concern

    included do
      handle500 = [Rails.env.development?, Rails.env.test?].none?
      rescue_from StandardError, with: :handle_internal_error if handle500

      rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing
      rescue_from Controllers::Errors::Api::BaseError, with: :handle_api_error
      rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
      rescue_from ActiveSupport::MessageVerifier::InvalidSignature, with: :handle_unauthorized
      rescue_from ActionController::InvalidAuthenticityToken, with: :handle_csrf
      # rescue_from ActionPolicy::Unauthorized, with: :handle_forbidden
      rescue_from Pagy::VariableError, with: :handle_pagy_variable_error
    end

    private

    def handle_internal_error(_internal_error)
      error = Controllers::Errors::Api::InternalServerError.new
      handle_api_error(error)
    end

    def valdation_failed!(validation_result)
      raise Controllers::Errors::Api::ValidationFailed, validation_result.errors.to_h
    end

    def handle_parameter_missing(error)
      message = I18n.t('errors.api.bad_request.missing_params', params: error.param)
      bad_request = Controllers::Errors::Api::BadRequest.new(message)
      handle_api_error(bad_request)
    end

    def handle_not_found(error)
      message = if error.id.nil?
                  I18n.t('errors.api.not_found.model', klass: error.model)
                else
                  I18n.t('errors.api.not_found.model_by', klass: error.model, by: :id, value: error.id)
                end

      not_found = Controllers::Errors::Api::NotFound.new(message)
      handle_api_error(not_found)
    end

    def handle_csrf(_error)
      undefined_csrf = Controllers::Errors::Api::Unauthorized.new(I18n.t('errors.api.unauthorized.invalid_csrf'))
      handle_api_error(undefined_csrf)
    end

    def handle_unauthorized(_)
      forbidden = Controllers::Errors::Api::Unauthorized.new
      handle_api_error(forbidden)
    end

    def handle_pagy_variable_error(error)
      bad_request = Controllers::Errors::Api::BadRequest.new(error.message)
      handle_api_error(bad_request)
    end

    def handle_api_error(error)
      serialized_error =
        case error
        when Controllers::Errors::Api::ValidationFailed
          { error: error.message, details: error.details }
        else
          { error: error.message }
        end

      render json: serialized_error, status: error.status
    end
  end
end
