# frozen_string_literal: true

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

          run_test! do |_response|
            expect(json_response['graduation_works'].size).to eq(10)
            expect(json_response['meta']['item_count']).to eq(GraduationWork.count)
            expect(json_response['graduation_works'].map { |gd| gd['id'] }).to include(graduation_works.first.id)
          end
        end

        context 'when filtered by params' do
          let(:example_schema) { { '$ref': '#/components/schemas/graduation_works_schema' } }
          let(:search_phrase) { graduation_works.first.title }

          run_test! do |_response|
            expect(json_response['graduation_works'].size).to be >= 1
            expect(json_response['graduation_works'].size).to be < 10
            expect(json_response['graduation_works'].map { |gd| gd['id'] }).to include(graduation_works.first.id)
          end
        end

        context 'when search_phrase is empty' do
          let(:example_schema) { { '$ref': '#/components/schemas/graduation_works_schema' } }
          let(:search_phrase) { '' }

          run_test! do |_response|
            expect(json_response['graduation_works'].size).to eq(10)
            expect(json_response['graduation_works'].map { |gd| gd['id'] }).to match_array(graduation_works.map(&:id))
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

  path '/api/v1/users/me/graduation_works' do
    get('all graduation_works') do
      tags 'GraduationWorks'

      security [access_token: []]

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
        let!(:graduation_works) { create_list(:graduation_work, 10, supervisor: user) }
        let(:user) { create(:employee) }

        schema '$ref': '#/components/schemas/graduation_works_schema'

        context 'when graduation works onwer is employee' do
          let(:Authorization) { access_token(user) }

          context 'when not filtered by params' do
            let(:example_schema) { { '$ref': '#/components/schemas/graduation_works_schema' } }

            run_test! do |_response|
              expect(json_response['graduation_works'].size).to eq(10)
              expect(json_response['meta']['item_count']).to eq(GraduationWork.count)
              expect(json_response['graduation_works'].map { |gd| gd['id'] }).to include(graduation_works.first.id)
            end
          end

          context 'when filtered by params' do
            let(:example_schema) { { '$ref': '#/components/schemas/graduation_works_schema' } }
            let(:search_phrase) { graduation_works.first.title }

            run_test! do |_response|
              expect(json_response['graduation_works'].size).to be >= 1
              expect(json_response['graduation_works'].size).to be < 10
              expect(json_response['graduation_works'].map { |gd| gd['id'] }).to include(graduation_works.first.id)
            end
          end

          context 'when graduation works that not belongs to user' do
            let(:example_schema) { { '$ref': '#/components/schemas/graduation_works_schema' } }

            before { create(:graduation_work) }

            run_test! do |_response|
              expect(json_response['graduation_works'].size).to eq(10)
              expect(GraduationWork.count).to eq(11)
              expect(json_response['graduation_works'].map { |gd| gd['id'] }).to include(graduation_works.first.id)
            end
          end
        end

        context 'when graduation works owner is student' do
          let(:example_schema) { { '$ref': '#/components/schemas/graduation_works_schema' } }

          let!(:thesis_defense) { create(:thesis_defense, author: student, graduation_work: graduation_work) }
          let!(:Authorization) { access_token(student) }
          let(:student) { create(:student, email: 'another@user.com') }
          let(:graduation_work) { create(:graduation_work) }

          run_test! do |_response|
            expect(json_response['graduation_works'].size).to eq(1)
            expect(GraduationWork.count).to eq(11)
            expect(json_response['graduation_works'][0]['id']).to eq(graduation_work.id)
          end
        end
      end

      response(400, 'bad request') do
        let(:user) { create(:employee) }
        let(:Authorization) { access_token(user) }

        include_examples 'invalid pagination parameter' do
          let(:items) { 'invaliditems' }
        end
      end
    end
  end
end
