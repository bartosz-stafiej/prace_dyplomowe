require 'swagger_helper'

RSpec.describe '/api/v1/users#me', type: :request do
    path '/api/v1/users/me' do
        get('get current user data') do
            tags 'Users'

            security [bearer_auth: []]

            produces 'application/json'

            response(200, 'successful') do
                let(:user) { create(:employee) }
                let(:Authorization) { 'Bearer token' }

                before { sign_in(user) }

                schema '$ref': '#/components/schemas/me_schema'

                let(:exmaple_schema) { { '$ref': '#/components/schemas/me_schema' } }

                run_test! { |response| expect(json_response['id']).to eq(user.id) }
            end

            response(401, 'unauthorized') do
                let(:user) { create(:employee) }
                let(:Authorization) { 'Bearer token' }
                let(:expected_message) { I18n.t('devise.failure.unauthenticated') }

                schema '$ref': '#/components/schemas/error_schema'

                let(:exmaple_schema) { { '$ref': '#/components/schemas/error_schema' } }

                run_test! { |response| expect(json_response['error']).to eq(expected_message) }
            end
        end
    end
end