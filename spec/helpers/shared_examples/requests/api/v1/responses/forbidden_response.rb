# frozen_string_literal: true

shared_examples 'forbidden response' do
  context 'when user is not authorized to perform action' do
    let(:expected_message) { I18n.t('errors.api.forbidden.default_message') }
    let(:example_schema) { { '$ref': '#/components/schemas/error_schema' } }

    run_test! do |_response|
      expect(json_response['error']).to eq(expected_message)
    end
  end
end
