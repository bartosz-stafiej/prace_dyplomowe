# frozen_string_literal: true

module GraduationWorks
  class SearchByTitleQuery
    def initialize(scope:, search_phrase:)
      @scope = scope
      @search_phrase = search_phrase
    end

    def call
      return scope unless search_phrase.is_a?(String)

      scope.where('title LIKE ?', "%#{search_phrase}%")
    end

    private

    attr_reader :search_phrase, :scope
  end
end
