# frozen_string_literal: true

require 'rails_helper'

describe KeyWord, type: :model do
  it { should have_db_column(:graduation_work_id).of_type(:integer).with_options(null: false) }
  it { should have_db_column(:key_word).of_type(:string).with_options(null: false) }

  it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
  it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }

  it {
    should belong_to(:graduation_work)
      .inverse_of(:key_words)
  }
end
