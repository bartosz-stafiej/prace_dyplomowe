# frozen_string_literal: true

shared_examples 'auth check' do
  response(401, 'unauthorized') do
    context 'when authorization headers does not contains token' do
      let(:Authorization) { nil }

      run_test! do |_response|
        expect(json_response['error']).to eq(I18n.t('errors.api.unauthorized.default_message'))
      end
    end

    context 'when authorization header contains invalid token' do
      let(:Authorization) { 'invalid-authorization-header' }

      run_test! do |_response|
        expect(json_response['error']).to eq(I18n.t('errors.api.unauthorized.default_message'))
      end
    end

    context 'when user authentication_token is invaid' do
      let(:user) { create(:employee) }
      let(:Authorization) { access_token(user) }

      before { user.authentication_token = 'test' }

      run_test! do |_response|
        expect(json_response['error']).to eq(I18n.t('errors.api.unauthorized.default_message'))
      end
    end
  end
end
