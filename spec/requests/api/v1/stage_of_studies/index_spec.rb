# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe '/api/v1/stage_of_studies#index', type: :request do
  path('/api/v1/stage_of_studies') do
    get('all stage of studies') do
      tags 'StageOfStudies'

      produces 'application/json'

      response(200, 'successful') do
        let!(:stage_of_studies) { create_list(:stage_of_study, 3) }

        schema '$ref': '#/components/schemas/stage_of_studies_schema'

        run_test! do |_response|
          expect(json_response['stage_of_studies'].size).to eq(3)
          expect(json_response['stage_of_studies'].map do |gd|
                   gd['id']
                 end).to match_array(stage_of_studies.map(&:id))
        end
      end
    end
  end
end
