require 'swagger_helper'

RSpec.describe '/api/v1/graduation_works#index', type: :request do
  path '/api/v1/graduation_works' do
    get('all graduation_works') do
      tags 'GraduationWorks'

      parameter name: :search_phrase,
                in: :query,
                required: false,
                description: 'invalid values discard the filter / search graduation works by title',
                schema: {
                  type: :string,
                  minLength: 1
                }

      parameter name: :items, in: :query, required: false,
                schema: {
                  type: :integer,
                  default: Pagy::VARS[:items],
                  minimum: 1,
                  maximum: Pagy::VARS[:max_items]
                }

      produces 'application/json'

      
      response(200, 'successful') do
        let!(:graduation_works) { create_list(:graduation_work, 10) }

        schema '$ref': '#/components/schemas/graduation_works_schema'

        context 'when not filtered by params' do
          let(:example_schema) { { '$ref': '#/components/schemas/graduation_works_schema' } }

          run_test! do |response|
            expect(json_response['graduation_works'].size).to eq(10)
            expect(json_response['meta']['item_count']).to eq(GraduationWork.count)
            expect(json_response['graduation_works'].map {|gd| gd['id']}).to include(graduation_works.first.id)
          end
        end

        context 'when filtered by params' do
          let(:example_schema) { { '$ref': '#/components/schemas/graduation_works_schema' } }
          let(:search_phrase) { graduation_works.first.title }

          run_test! do |response|
            expect(json_response['graduation_works'].size).to be >= 1 
            expect(json_response['graduation_works'].size).to be < 10
            expect(json_response['graduation_works'].map {|gd| gd['id']}).to include(graduation_works.first.id)
          end
        end
      end

      response(400, 'bad request') do
        include_examples 'invalid pagination parameter' do
          let(:items) { 'invaliditems' }
        end
      end
    end
  end
end