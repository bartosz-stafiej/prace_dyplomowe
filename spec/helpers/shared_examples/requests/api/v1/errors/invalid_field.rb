# frozen_string_literal: true

shared_examples 'invalid field' do |description:|
  context description do
    let(:expected_message) { I18n.t('errors.api.validation_failed.default_message') }
    let(:example_schema) { { '$ref': '#/components/schemas/error_schema' } }

    let(:input) { attributes_for(factory).merge(key => value) }

    run_test! do |_response|
      expect(json_response['error']).to eq(expected_message)
      expect(json_response['details']).to eq(key.to_s => [key_message])
    end
  end
end
