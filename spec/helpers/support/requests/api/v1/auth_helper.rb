module Requests
    module Api
        module V1
            module AuthHelper
                def sign_in(user)
                    login_as(user, scope: :user)
                end
            end
        end
    end
end

RSpec.configure do |config|
    config.include Requests::Api::V1::AuthHelper, type: :request
    config.include Warden::Test::Helpers
end