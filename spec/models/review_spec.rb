# frozen_string_literal: true

require 'rails_helper'

describe Review, type: :model do
  it { should have_db_column(:grade).of_type(:decimal).with_options(null: false) }
  it { should have_db_column(:comment).of_type(:text).with_options(null: false) }
  it { should have_db_column(:date_of_issue).of_type(:datetime).with_options(null: false) }

  it {
    should belong_to(:graduation_work)
      .inverse_of(:reviews)
  }

  it {
    should belong_to(:reviewer)
      .class_name(:Employee)
      .inverse_of(:reviews)
  }
end
