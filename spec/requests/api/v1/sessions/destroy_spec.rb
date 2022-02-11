require 'swagger_helper'

RSpec.describe '/api/v1/sessions#destroy', type: :request do
    path '/api/v1/logout' do
        delete('login user') do
            tags 'Sessions'

            security [access_token: []]

            consumes 'application/json'

            include_examples 'auth check'

            response(204, 'no content') do
                let(:user) { create(:employee) }
                let(:update_authentication_token) do
                    instance_double(Sessions::UpdateAuthenticationToken)
                end

                before do
                    expect(Sessions::UpdateAuthenticationToken)
                        .to receive(:new)
                        .with(user: user)
                        .and_return(update_authentication_token)

                    expect(update_authentication_token)
                        .to receive(:call)
                end

                context 'when Authorization headers contains valid token' do
                    let(:Authorization) { access_token(user) }

                    run_test! do |response|
                        expect(response.body).to be_empty
                    end
                end
            end
        end
    end
end