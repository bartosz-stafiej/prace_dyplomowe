# frozen_string_literal: true

require 'constants/pagy'

module Api
  module V1
    class BaseController < ApplicationController
      include Pagy::Backend

      DEFAULT_ITEMS_PARAM = Constants::Pagy::DEFAULT_ITEMS_PARAM

      private

      def items
        params[:items] || DEFAULT_ITEMS_PARAM
      end
    end
  end
end
