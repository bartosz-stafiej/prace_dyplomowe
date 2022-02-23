require 'swagger_helper'

RSpec.describe '/api/v1/graduation_works/:graduation_work_id/reviews/', type: :request do
    path('/api/v1/graduation_works/{graduation_work_id}/reviews') do
        post('create new review') do
            tags 'Reviews'

            security [access_token: []]

            consumes 'application/json'
            produces 'application/json'

            parameter name: :graduation_work_id, in: :path, type: :integer
            parameter name: :input,
                      in: :body,
                      schema: {
                          type: 'object',
                          required: %w[comment date_of_issue grade reviewer_id],
                          properties: {
                            comment: {
                                type: 'string',
                                maxLength: Reviews::CreateContract::COMMENT_MAX_LENGTH
                            },
                            date_of_issue: {
                                type: 'string',
                                format: 'date-time'
                            },
                            grade: {
                                type: 'float',
                                enum: Reviews::CreateContract::GRADES
                            },
                            reviewer_email: {
                                type: 'integer',
                                format: Reviews::CreateContract::EMAIL_FORMAT
                            }
                          }
                      }

            include_examples 'auth check' do
                let(:input) do
                    attributes_for(:review)
                    .merge(
                        reviewer_email: reviewer.email
                    )
                end
                let(:reviewer) { create(:employee) }
                let(:graduation_work) { create(:graduation_work) }
                let(:graduation_work_id) { graduation_work.id }
            end

            response(200, 'successful') do
                let(:reviewer) { create(:employee) }
                let(:Authorization) { access_token(reviewer) }
                let(:graduation_work) { create(:graduation_work) }
                let(:graduation_work_id) { graduation_work.id }

                let(:input) do
                    attributes_for(:review)
                        .merge(
                            reviewer_email: reviewer.email
                        )
                end

                schema '$ref': '#/components/schemas/review_schema'

                run_test! do |response|
                    expect(json_response['review']['id']).not_to be_nil
                    expect(json_response['review']['comment']).to eq(input[:comment])
                end
            end

            response(422, 'validation failed') do
                let(:reviewer) { create(:employee) }
                let(:Authorization) { access_token(reviewer) }
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
                let(:user) { create(:student) }
                let(:Authorization) { access_token(user) }
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
                let(:user) { create(:employee) }
                let(:Authorization) { access_token(user) }
                let(:graduation_work_id) { 0 }
                let(:expected_response) do
                    I18n.t('errors.api.not_found.model_by',
                        klass: 'GraduationWork',
                        by: 'id',
                        value: graduation_work_id
                    )
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