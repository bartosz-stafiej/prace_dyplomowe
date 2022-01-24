# frozen_string_literal: true

module ParseJsonResponse
  def json_response
    JSON.parse(response.body)
  end
end

RSpec.configure do |config|
  config.include ParseJsonResponse, type: :request
end
