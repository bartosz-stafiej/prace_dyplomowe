# frozen_string_literal: true

module Constants
  module Users
    module Formats
      EMAIL_FORMAT = /\A[^@\s]+@[^@\s]+\z/
      TELEPHONE_FORMAT = /\+\d{2}\d{9}|\d{9}/
    end
  end
end
