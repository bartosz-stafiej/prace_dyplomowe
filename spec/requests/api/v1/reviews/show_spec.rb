# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe '/api/v1/graduation_works/:graduation_work_id/reviews/:id#show', type: :request do
  path('/api/v1/graduation_works/{graduation_work_id}/reviews/{id}') do
    get('get a review data') do
      tags 'Reviews'

      security [access_token: []]

      parameter name: :graduation_work_id, in: :path, type: :integer
      parameter name: :id, in: :path, type: :integer

      include_examples 'auth check' do
        let(:review) { create(:review, graduation_work: graduation_work) }
        let(:graduation_work) { create(:graduation_work) }

        let(:id) { review.id }
        let(:graduation_work_id) { graduation_work.id }
      end

      response(200, 'successful') do
        let(:employee) { create(:employee) }
        let(:Authorization) { access_token(employee) }
        let(:review) { create(:review, graduation_work: graduation_work) }
        let(:graduation_work) { create(:graduation_work) }

        let(:id) { review.id }
        let(:graduation_work_id) { graduation_work.id }

        schema '$ref': '#/components/schemas/review_schema'

        run_test! do |_response|
          expect(json_response['review']['id']).to eq(review.id)
        end
      end

      response(403, 'forbidden') do
        let(:student) { create(:student) }
        let(:Authorization) { access_token(student) }
        let(:review) { create(:review, graduation_work: graduation_work) }
        let(:graduation_work) { create(:graduation_work) }

        let(:id) { review.id }
        let(:graduation_work_id) { graduation_work.id }

        schema '$ref': '#/components/schemas/error_schema'

        let(:expected_response) do
          I18n.t('errors.api.forbidden.default_message')
        end

        run_test! do |_response|
          expect(json_response['error']).to eq(expected_response)
        end
      end

      response(404, 'not found') do
        let(:employee) { create(:employee) }
        let(:Authorization) { access_token(employee) }
        let(:review) { create(:review, graduation_work: graduation_work) }
        let(:graduation_work) { create(:graduation_work) }

        schema '$ref': '#/components/schemas/error_schema'

        context 'when graduation work does not exist' do
          let(:expected_response) do
            I18n.t('errors.api.not_found.model_by',
                   klass: 'GraduationWork',
                   by: 'id',
                   value: graduation_work_id)
          end

          let(:id) { review.id }
          let(:graduation_work_id) { 0 }

          run_test! do |_response|
            expect(json_response['error']).to eq(expected_response)
          end
        end

        context 'when review does not exist' do
          let(:expected_response) do
            I18n.t('errors.api.not_found.model_by',
                   klass: 'Review',
                   by: 'id',
                   value: id)
          end

          let(:id) { 0 }
          let(:graduation_work_id) { graduation_work.id }

          run_test! do |_response|
            expect(json_response['error']).to eq(expected_response)
          end
        end
      end
    end
  end
end
