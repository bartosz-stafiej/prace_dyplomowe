# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe '/api/v1/graduation_works/:graduation_work_id/reviews/:id#update', type: :request do
  path('/api/v1/graduation_works/{graduation_work_id}/reviews/{id}') do
    put('update review') do
      tags 'Reviews'

      security [access_token: []]

      consumes 'application/json'
      produces 'application/json'

      parameter name: :graduation_work_id, in: :path, type: :integer
      parameter name: :id, in: :path, type: :integer
      parameter name: :input,
                in: :body,
                schema: {
                  type: 'object',
                  required: %w[comment date_of_issue grade reviewer_id],
                  properties: {
                    comment: {
                      type: 'string',
                      maxLength: Reviews::UpdateContract::COMMENT_MAX_LENGTH
                    },
                    date_of_issue: {
                      type: 'string',
                      format: 'date-time'
                    },
                    grade: {
                      type: 'float',
                      enum: Reviews::UpdateContract::GRADES
                    },
                    reviewer_email: {
                      type: 'integer',
                      format: Reviews::UpdateContract::EMAIL_FORMAT
                    }
                  }
                }

      include_examples 'auth check' do
        let(:input) { {} }
        let(:id) { review.id }
        let(:review) { create(:review, graduation_work: graduation_work, reviewer: reviewer) }
        let(:reviewer) { create(:employee) }
        let(:graduation_work) { create(:graduation_work) }
        let(:graduation_work_id) { graduation_work.id }
      end

      response(200, 'successful') do
        let(:id) { review.id }
        let(:review) { create(:review, graduation_work: graduation_work, reviewer: reviewer) }
        let(:graduation_work) { create(:graduation_work) }
        let(:graduation_work_id) { graduation_work.id }

        let(:reviewer) { create(:employee) }

        let(:Authorization) { access_token(reviewer) }

        let(:valid_input) { { comment: 'updated comment' } }

        schema '$ref': '#/components/schemas/review_schema'

        context 'when not updating reviewer' do
          let(:input) { valid_input }

          run_test! do |_response|
            expect(json_response['review']['id']).not_to be_nil
            expect(json_response['review']['reviewer']['id']).to eq(reviewer.id)
          end
        end

        context 'when updating reviewer' do
          let(:input) { valid_input.merge(reviewer_email: new_reviewer.email) }

          let(:new_reviewer) { create(:employee) }

          run_test! do |_response|
            expect(json_response['review']['id']).to eq(review.id)
            expect(json_response['review']['reviewer']['id']).to eq(new_reviewer.id)
            expect(json_response['review']['comment']).to eq(input[:comment])
          end
        end
      end

      response(422, 'validation failed') do
        let(:reviewer) { create(:employee) }
        let(:Authorization) { access_token(reviewer) }

        let(:review) { create(:review, graduation_work: graduation_work, reviewer: reviewer) }
        let(:id) { review.id }

        let(:graduation_work) { create(:graduation_work) }
        let(:graduation_work_id) { graduation_work.id }

        it_behaves_like 'invalid field', description: 'when reviewer does not exist' do
          let(:factory) { :review }
          let(:key) { :reviewer_email }
          let(:value) { 'not@found.com' }
          let(:key_message) do
            I18n.t!(
              'dry_validation.errors.reviews.create.rules.reviewer_email.not_found',
              email: value
            )
          end
        end
      end

      response(403, 'forbidden') do
        let(:reviewer) { create(:student) }
        let(:Authorization) { access_token(reviewer) }

        let(:review) { create(:review, graduation_work: graduation_work) }
        let(:id) { review.id }

        let(:graduation_work) { create(:graduation_work) }
        let(:graduation_work_id) { graduation_work.id }

        let(:expected_response) do
          I18n.t('errors.api.forbidden.default_message')
        end

        let(:input) { {} }

        schema '$ref': '#/components/schemas/error_schema'

        run_test! do |_response|
          expect(json_response['error']).to eq(expected_response)
        end
      end

      response(404, 'not found') do
        let(:reviewer) { create(:employee) }
        let(:Authorization) { access_token(reviewer) }

        let(:review) { create(:review, graduation_work: graduation_work, reviewer: reviewer) }
        let(:graduation_work) { create(:graduation_work) }

        let(:input) { {} }

        schema '$ref': '#/components/schemas/error_schema'

        context 'when graduation work does not exist' do
          let(:graduation_work_id) { 0 }
          let(:id) { review.id }
          let(:expected_response) do
            I18n.t('errors.api.not_found.model_by',
                   klass: 'GraduationWork',
                   by: 'id',
                   value: graduation_work_id)
          end
          let(:example_schema) { { '$ref': '#/components/schemas/error_schema' } }

          run_test! do |_response|
            expect(json_response['error']).to eq(expected_response)
          end
        end

        context 'when review does not exist' do
          let(:graduation_work_id) { graduation_work.id }
          let(:id) { 0 }
          let(:expected_response) do
            I18n.t('errors.api.not_found.model_by',
                   klass: 'Review',
                   by: 'id',
                   value: id)
          end
          let(:example_schema) { { '$ref': '#/components/schemas/error_schema' } }

          run_test! do |_response|
            expect(json_response['error']).to eq(expected_response)
          end
        end
      end
    end
  end
end
