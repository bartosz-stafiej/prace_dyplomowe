# frozen_string_literal: true

module GraduationWorks
  class SearchByTitleQuery
    def initialize(scope:, search_phrase:)
      @scope = scope
      @search_phrase = search_phrase
    end

    def call
      return scope unless valid_scope?

      scope.where('title LIKE ?', "%#{search_phrase}%")
    end

    private

    def valid_scope?
      search_phrase.is_a?(String) && !search_phrase.empty?
    end

    attr_reader :search_phrase, :scope
  end
end
