# frozen_string_literal: true

shared_examples 'not found response' do |klass:|
  context "when could not find #{klass}" do
    let(:by) { search_param.keys.first }
    let(:value) { search_param.values.first }

    let(:expected_message) do
      I18n.t!('errors.api.not_found.model_by', klass: klass, by: by, value: value)
    end
    let(:example_schema) { { '$ref': '#components/schemas/error_schema' } }

    run_test! do |_response|
      expect(json_response['error']).to include(expected_message)
    end
  end
end
