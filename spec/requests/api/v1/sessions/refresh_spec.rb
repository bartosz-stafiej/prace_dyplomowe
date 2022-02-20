# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe '/api/v1/sessions#refresh_token', type: :request do
  path('/api/v1/refresh_token') do
    post('refresh auth token') do
      tags 'Sessions'

      security [refresh_token: []]

      produces 'application/json'

      response(200, 'successful') do
        let(:user) { create(:employee) }
        let(:Authorization) { refresh_token(user) }
        let(:authorization_tokens_generator) { instance_double(TokenGenerator::AuthorizationTokenGenerator) }

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

      response(401, 'unauthorized') do
        let(:user) { create(:user) }

        schema '$ref': '#/components/schemas/error_schema'

        context 'when invalid refresh token' do
          let(:Authorization) { 'invalid-token' }
          let(:expected_response) { I18n.t('errors.api.unauthorized.default_message') }

          run_test! do |_response|
            expect(json_response['error']).to eq(expected_response)
          end
        end
      end
    end
  end
end
