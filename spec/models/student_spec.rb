# frozen_string_literal: true

require 'rails_helper'

describe Student, type: :model do
  it {
    should belong_to(:college)
      .inverse_of(:students)
      .optional
  }

  it {
    should have_many(:thesis_defenses)
      .inverse_of(:author)
      .dependent(:nullify)
  }
end
