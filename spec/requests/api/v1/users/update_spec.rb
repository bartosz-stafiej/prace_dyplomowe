# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe '/api/v1/users#update', type: :request do
  path('/api/v1/users') do
    put('update current user') do
      tags 'Users'

      security [access_token: []]

      consumes 'application/json'

      parameter name: :input,
                in: :body,
                description: 'current user data to be updated',
                schema: {
                  type: 'object',
                  required: %w[],
                  properties: {
                    email: {
                      type: 'string',
                      format: Users::UpdateContract::EMAIL_FORMAT
                    },
                    first_name: {
                      type: 'string',
                      maxLength: Users::UpdateContract::NAME_MAX_LENGTH
                    },
                    last_name: {
                      type: 'string',
                      maxLength: Users::UpdateContract::NAME_MAX_LENGTH
                    },
                    academic_degree: {
                      type: 'string',
                      enum: Users::UpdateContract::ACADEMIC_DEGREES
                    },
                    telephone_number: {
                      type: 'string',
                      format: Users::UpdateContract::TELEPHONE_FORMAT
                    }
                  }
                }

      include_examples 'auth check' do
        let(:input) { {} }
      end

      response(200, 'successful') do
        let(:user) { create(:employee) }

        let(:Authorization) { access_token(user) }

        schema '$ref': '#/components/schemas/me_schema'

        let(:input) { { email: 'new@email.com', first_name: 'NewName' } }

        let(:example_schema) { { '$ref': '#/components/schemas/me_schema' } }

        run_test! do |_response|
          expect(json_response['id']).to eq(user.id)
          expect(json_response['email']).to eq(input[:email])
        end
      end

      response(422, 'validation failed') do
        let(:user) { create(:employee) }
        let(:another_user) { create(:employee, email: 'another@email.com') }

        let(:Authorization) { access_token(user) }

        it_behaves_like 'invalid field', description: 'when email is in invalid format' do
          let(:factory) { :employee }
          let(:key) { :email }
          let(:value) { 'not-valid-email' }
          let(:key_message) { 'is in invalid format' }
        end

        it_behaves_like 'invalid field', description: 'when email already exists' do
          let(:factory) { :employee }
          let(:key) { :email }
          let(:value) { another_user.email }
          let(:key_message) do
            I18n.t!('dry_validation.errors.taken')
          end
        end

        it_behaves_like 'invalid field', description: 'when academic degree does not exist' do
          let(:factory) { :employee }
          let(:key) { :academic_degree }
          let(:value) { 'invalid' }
          let(:key_message) { 'must be one of: prof. dr., mg., dr.' }
        end
      end
    end
  end
end
