# frozen_string_literal: true

require 'rails_helper'
require 'constants/empty'

def parse_swagger_schema(name, version: 'v1')
  JSON.parse(File.read("swagger/#{version}/schemas/#{name}.json"))
end

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      servers: [
        {
          url: 'https://pracedyplomowe.herokuapp.com/',
          description: 'Staging'
        },
        {
          url: 'http://localhost:3000/',
          description: 'Localhost'
        }
      ],
      components: {
        securitySchemes: {
          basic_auth: {
            type: :http,
            scheme: :basic
          },
          access_token: {
            type: :access_token,
            name: 'access_token',
            in: :headers
          },
          refresh_token: {
            type: :refresh_token,
            name: 'refresh_token',
            in: :headers
          }
        },
        schemas: {
          auth_schema: parse_swagger_schema('auth_schema'),
          me_schema: parse_swagger_schema('me_schema'),
          error_schema: parse_swagger_schema('error_schema'),
          graduation_work_schema: parse_swagger_schema('graduation_work_schema'),
          graduation_works_schema: parse_swagger_schema('graduation_works_schema'),
          tokens_schema: parse_swagger_schema('tokens_schema')
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml

  config.after do |example|
    next if example.metadata[:example_response] == false ||
            example.metadata[:response].nil? ||
            example.metadata[:operation][:produces].nil? ||
            response.body == Constants::Empty::STRING

    example.metadata[:response][:content] = {
      example.metadata[:operation][:produces].first => {
        schema: respond_to?(:example_schema) ? example_schema : example.metadata[:response][:schema],
        examples: {
          example.metadata[:example_group][:description] => {
            value: JSON.parse(response.body, symbolize_names: true)
          }
        }
      }
    }
  end
end
