# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe '/api/v1/users#me', type: :request do
  path '/api/v1/users/me' do
    get('get current user data') do
      tags 'Users'

      security [access_token: []]

      produces 'application/json'

      include_examples 'auth check'

      response(200, 'successful') do
        let(:user) { create(:employee) }

        schema '$ref': '#/components/schemas/me_schema'

        let(:exmaple_schema) { { '$ref': '#/components/schemas/me_schema' } }

        context 'when no content response' do
          let(:Authorization) { access_token(user) }

          run_test! { |_response| expect(json_response['id']).to eq(user.id) }
        end
      end
    end
  end
end
