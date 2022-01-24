# frozen_string_literal: true

Dir["/queries/raports/subscopes/*.rb"].each {|file| require file }

module Raports
  class ScopeQuery

    def initialize(search_params:)
      @search_params = search_params
    end

    def call
      params = prepare_params!

      scope = GraduationWork.all
      params.each do |param, search_phrase|
        scope = 
          Raports::Subscopes.const_get(param.to_s.camelize + 'Scope')
            .call(
              scope: scope,
              search_phrase: search_phrase
            )
      end
      scope
    end

    private

    def prepare_params!
      date_range = search_params[:date_from]..search_params[:date_to]
      search_params.except(:date_from, :date_to).merge(date_range: date_range) if date_range
    end

    attr_reader :search_params
  end
end
