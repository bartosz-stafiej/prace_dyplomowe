# frozen_string_literal: true

module Sessions
  class Authenticator
    def initialize(password:, email:)
      @password = password
      @email = email
    end

    def call
      user = User.find_by(email: email)

      return user if user&.authenticate(password)

      raise Controllers::Errors::Api::Unauthorized
    end

    private

    attr_reader :password, :email
  end
end
