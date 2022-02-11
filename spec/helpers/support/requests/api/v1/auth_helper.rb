module Requests
    module Api
        module V1
            module AuthHelper
                def access_token(user)
                    TokenGenerator::AccessTokenGenerator.new(user: user).call
                end
                
                def refresh_token(user)
                    TokenGenerator::RefreshTokenGenerator.new(user: user).call
                end
            end
        end
    end
end

RSpec.configure do |config|
    config.include Requests::Api::V1::AuthHelper
end