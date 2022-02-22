# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe '/api/v1/graduation_works/:id#update', type: :request do
  path('/api/v1/graduation_works/{id}') do
    put('update graduation work') do
      tags 'Courses'

      security [access_token: []]

      consumes 'application/json'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer
      parameter name: :input,
                in: :body,
                schema: {
                  type: 'object',
                  properties: {
                    title: {
                      type: 'string',
                      maxLength: GraduationWorks::UpdateContract::TITLE_MAX_LENGTH
                    },
                    topic: {
                      type: 'string',
                      maxLength: GraduationWorks::UpdateContract::TOPIC_MAX_LENGTH
                    },
                    date_of_submission: {
                      type: 'string',
                      format: 'date-time'
                    },
                    stage_of_study_id: {
                      type: 'integer',
                      description: 'must refer to existing stage_of_study'
                    },
                    supervisor_id: {
                      type: 'integer',
                      description: 'must refer to existing employee'
                    }
                  }
                }

      include_examples 'auth check' do
        let(:input) { {} }
        let(:id) { 0 }
      end

      response(200, 'successful') do
        let(:graduation_work) { create(:graduation_work) }
        let(:valid_input) { { title: 'another title', topic: 'updated topic' } }
        let(:id) { graduation_work.id }

        let(:user) { create(:employee) }
        let(:Authorization) { access_token(user) }

        schema '$ref': '#/components/schemas/graduation_work_schema'

        context 'when not updating supervisor' do
          let(:input) { valid_input }
          let(:example_schema) { { '$ref': '#/components/schemas/graduation_work_schema' } }

          run_test! do |_response|
            expect(json_response['graduation_work']['id']).to eq(graduation_work.id)
            expect(json_response['graduation_work']['title']).to eq(input[:title])
            expect(json_response['graduation_work']['supervisor']['email']).to eq(graduation_work.supervisor.email)
          end
        end

        context 'when updating supervisor' do
          let(:input) { valid_input.merge(supervisor_email: supervisor.email) }
          let(:example_schema) { { '$ref': '#/components/schemas/graduation_work_schema' } }

          let(:supervisor) { create(:employee) }

          run_test! do |_response|
            expect(json_response['graduation_work']['id']).to eq(graduation_work.id)
            expect(json_response['graduation_work']['title']).to eq(input[:title])
            expect(json_response['graduation_work']['supervisor']['email']).to eq(input[:supervisor_email])
          end
        end
      end

      response(422, 'validation failed') do
        let(:user) { create(:employee) }
        let(:graduation_work) { create(:graduation_work) }
        let(:Authorization) { access_token(user) }

        it_behaves_like 'invalid field', description: 'when supervisor does not exist' do
          let(:factory) { :graduation_work }
          let(:key) { :supervisor_email }
          let(:value) { 'invalid@email.com' }
          let(:id) { graduation_work.id }
          let(:key_message) do
            I18n.t!(
              'dry_validation.errors.graduation_works.create.rules.supervisor_email.not_found',
              email: value
            )
          end
        end

        it_behaves_like 'invalid field', description: 'when stage of study does not exist' do
          let(:factory) { :graduation_work }
          let(:key) { :stage_of_study_id }
          let(:id) { graduation_work.id }
          let(:value) { 20 }
          let(:key_message) do
            I18n.t!(
              'dry_validation.errors.graduation_works.create.rules.stage_of_study_id.not_found',
              id: value
            )
          end

          before { input.merge!(supervisor_email: user.email) }
        end

        it_behaves_like 'invalid field', description: 'when date of study after today' do
          let(:factory) { :graduation_work }
          let(:key) { :date_of_submission }
          let(:id) { graduation_work.id }
          let(:value) { 1.month.from_now }
          let(:key_message) do
            I18n.t('dry_validation.errors.graduation_works.create.rules.date_of_submission.invalid_date')
          end
        end
      end

      response(404, 'not found') do
        let(:user) { create(:employee) }
        let(:Authorization) { access_token(user) }
        let(:input) { {} }
        let(:id) { 0 }
        let(:expected_response) do
          I18n.t(
            'errors.api.not_found.model_by',
            klass: 'GraduationWork',
            by: 'id',
            value: 0
          )
        end

        schema '$ref': '#/components/schemas/error_schema'

        run_test! do |_response|
          expect(json_response['error']).to eq(expected_response)
        end
      end

      response(403, 'forbidden') do
        let(:user) { create(:student) }
        let(:Authorization) { access_token(user) }
        let(:expected_response) do
          I18n.t('errors.api.forbidden.default_message')
        end

        let(:input) { {} }

        schema '$ref': '#/components/schemas/error_schema'

        run_test! do |_response|
          expect(json_response['error']).to eq(expected_response)
        end
      end
    end
  end
end
