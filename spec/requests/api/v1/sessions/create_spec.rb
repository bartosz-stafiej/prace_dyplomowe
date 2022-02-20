# frozen_string_literal: true

require 'swagger_helper'
require './app/contracts/sessions/create_contract'

RSpec.describe '/api/v1/sessions#create', type: :request do
  path '/api/v1/login' do
    post('login user') do
      tags 'Sessions'

      parameter name: :input,
                in: :body,
                description: 'email and password for authentication',
                schema: {
                  type: 'object',
                  required: %(email password),
                  properties: {
                    email: {
                      type: 'string',
                      format: Sessions::CreateContract::EMAIL_FORMAT
                    },
                    password: {
                      type: 'string',
                      minLength: 1,
                      maxLength: Sessions::CreateContract::PASSWORD_MAX_LENGTH
                    }
                  }
                }

      produces 'application/json'
      consumes 'application/json'

      response(200, 'successful') do
        let(:user) { create(:employee, password: 'password', password_confirmation: 'password') }
        let(:authorization_tokens_generator) { instance_double(TokenGenerator::AuthorizationTokenGenerator) }
        let(:input) { { email: user.email, password: 'password' } }

        schema '$ref': '#/components/schemas/auth_schema'

        let(:tokens) do
          {
            'access_token' => {
              'expires_in' => 1800,
              'token' => 'authorization_token'
            },
            'refresh_token' => {
              'expires_in' => 3600,
              'token' => 'refresh_token'
            }
          }
        end

        let(:expected_response) do
          {
            'user' => {
              'id' => user.id,
              'created_at' => user.created_at.strftime('%Y-%m-%d %H:%M:%S UTC'),
              'email' => user.email,
              'updated_at' => user.updated_at.strftime('%Y-%m-%d %H:%M:%S UTC'),
              'type' => user.type,
              'tokens' => tokens
            }
          }
        end

        before do
          expect(TokenGenerator::AuthorizationTokenGenerator)
            .to receive(:new)
            .with(user: user)
            .and_return(authorization_tokens_generator)

          expect(authorization_tokens_generator)
            .to receive(:call)
            .and_return(tokens)
        end

        run_test! do |_response|
          expect(json_response).to eq(expected_response)
        end
      end

      response(422, 'validation filed') do
        it_behaves_like 'invalid field', description: 'when email is in invalid format' do
          let(:factory) { :employee }
          let(:key) { :email }
          let(:value) { 'is in invalid format' }
          let(:key_message) do
            I18n.t!('dry_validation.sessions.create.invalid_email_format')
          end
        end
      end

      response(401, 'unauthorized') do
        let(:user) { create(:user) }

        schema '$ref': '#/components/schemas/error_schema'

        context 'when invalid email or password' do
          let(:input) { { email: 'not@found.com', password: 'password' } }
          let(:expected_response) { I18n.t('errors.api.unauthorized.default_message') }

          run_test! do |_response|
            expect(json_response['error']).to eq(expected_response)
          end
        end
      end
    end
  end
end
