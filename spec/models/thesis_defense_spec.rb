# frozen_string_literal: true

require 'rails_helper'

describe ThesisDefense, type: :model do
  it { should have_db_column(:defence_address).of_type(:string).with_options(null: false) }
  it { should have_db_column(:final_grade).of_type(:decimal).with_options(null: true) }
  it { should have_db_column(:date_of_defence).of_type(:datetime).with_options(null: false) }
  it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
  it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }

  it {
    should belong_to(:evaluator)
      .class_name(:Employee)
      .inverse_of(:thesis_defenses)
  }

  it {
    should belong_to(:author)
      .class_name(:Student)
      .inverse_of(:thesis_defenses)
  }

  it {
    should belong_to(:graduation_work)
      .inverse_of(:thesis_defenses)
  }
end
