# frozen_string_literal: true

require 'rails_helper'

describe College, type: :model do
  it { should have_db_column(:faculty).of_type(:string).with_options(null: false) }
  it { should have_db_column(:field_of_study).of_type(:string).with_options(null: false) }

  it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
  it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }

  it {
    should have_many(:students)
      .inverse_of(:college)
      .dependent(:delete_all)
  }
end
