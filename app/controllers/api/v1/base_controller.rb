# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      include ErrorsHandler

      after_action :merge_pagy_headers_if_present

      def merge_pagy_headers_if_present
        pagy_headers_merge(@pagy) if @pagy
      end
    end
  end
end
