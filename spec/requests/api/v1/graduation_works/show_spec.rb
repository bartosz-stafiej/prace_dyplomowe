require 'swagger_helper'

RSpec.describe '/api/v1/graduation_works#show', type: :request do
    path '/api/v1/graduation_works/{id}' do
        get('Get specific graduation work') do
            tags 'GraduationWorks'

            produces 'application/json'

            parameter name: :id, in: :path, type: :integer

            response(200, 'successful') do
                let!(:review) { create(:review, graduation_work: graduation_work, reviewer: supervisor) }
                let!(:thesis_defense) { create(:thesis_defense, graduation_work: graduation_work, author: author) }
                let(:graduation_work) { create(:graduation_work, supervisor: supervisor) }
                let(:author) { create(:student) }
                let(:supervisor) { create(:employee) }

                let(:id) { graduation_work.id }

                schema '$ref': '#/components/schemas/graduation_work_schema'

                context 'when successful request' do
                    let(:exmaple_schema) { { '$ref': '#/components/schemas/graduation_work_schema' } }

                    run_test! do |response|
                        expect(json_response['graduation_work']['id']).to eq(graduation_work.id)
                        expect(json_response['graduation_work']['thesis_defenses'][0]['id']).to eq(thesis_defense.id)
                        expect(json_response['graduation_work']['supervisor']['id']).to eq(supervisor.id)
                        expect(json_response['graduation_work']['reviews'][0]['id']).to eq(review.id)
                    end
                end
            end

            response(404, 'not_found') do
                let(:id) { 0 }
                let(:search_param) { { 'id' => id } }

                include_examples 'not found response', klass: 'GraduationWork'
            end
        end
    end
end