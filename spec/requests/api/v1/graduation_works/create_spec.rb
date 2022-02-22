# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/v1/graduation_works#create', type: :request do
  path('/api/v1/graduation_works') do
    post('create new graduation work') do
      tags 'GraduationWorks'

      security [access_token: []]

      consumes 'application/json'
      produces 'application/json'

      parameter name: :input,
                in: :body,
                schema: {
                  type: 'object',
                  required: %(title, topic, date_of_submission, stage_of_study_id supervisor_id),
                  properties: {
                    title: {
                      type: 'string',
                      maxLength: GraduationWorks::CreateContract::TITLE_MAX_LENGTH
                    },
                    topic: {
                      type: 'string',
                      maxLength: GraduationWorks::CreateContract::TOPIC_MAX_LENGTH
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

      let(:valid_input) do
        supervisor = create(:employee)
        stage_of_study = create(:stage_of_study)

        attributes_for(:graduation_work)
          .merge(
            supervisor_email: supervisor.email,
            stage_of_study_id: stage_of_study.id
          )
      end

      include_examples 'auth check' do
        let(:input) { valid_input }

        let(:supervisor) { create(:employee) }
        let(:stage_of_study) { create(:stage_of_study) }
      end

      response(201, 'created') do
        let(:user) { create(:employee) }
        let(:Authorization) { access_token(user) }
        let(:stage_of_study) { create(:stage_of_study) }

        schema '$ref': '#/components/schemas/graduation_work_schema'

        let(:input) { valid_input }

        run_test! do |_response|
          expect(json_response['graduation_work']['id']).not_to be_nil
          expect(json_response['graduation_work']['title']).to eq(input[:title])
          expect(json_response['graduation_work']['supervisor']['id']).not_to be_nil
        end
      end

      response(403, 'forbidden') do
        let(:user) { create(:student) }
        let(:Authorization) { access_token(user) }
        let(:supervisor) { create(:employee) }
        let(:stage_of_study) { create(:stage_of_study) }
        let(:expected_response) do
          I18n.t('errors.api.forbidden.default_message')
        end

        let(:input) { valid_input }

        schema '$ref': '#/components/schemas/error_schema'

        run_test! do |_response|
          expect(json_response['error']).to eq(expected_response)
        end
      end

      response(422, 'validation failed') do
        let(:user) { create(:employee) }
        let(:stage_of_study) { create(:stage_of_study) }
        let(:Authorization) { access_token(user) }

        it_behaves_like 'invalid field', description: 'when supervisor does not exist' do
          let(:factory) { :graduation_work }
          let(:key) { :supervisor_email }
          let(:value) { 'invalid@email.com' }
          let(:key_message) do
            I18n.t!(
              'dry_validation.errors.graduation_works.create.rules.supervisor_email.not_found',
              email: value
            )
          end

          before { input.merge!(stage_of_study_id: stage_of_study.id) }
        end

        it_behaves_like 'invalid field', description: 'when stage of study does not exist' do
          let(:factory) { :graduation_work }
          let(:key) { :stage_of_study_id }
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
          let(:value) { 1.month.from_now }
          let(:key_message) do
            I18n.t('dry_validation.errors.graduation_works.create.rules.date_of_submission.invalid_date')
          end

          before do
            input.merge!(
              supervisor_email: user.email,
              stage_of_study_id: stage_of_study.id
            )
          end
        end
      end
    end
  end
end
