# frozen_string_literal: true

class KeyWord < ApplicationRecord
  belongs_to :graduation_work,
             inverse_of: :key_words
end
