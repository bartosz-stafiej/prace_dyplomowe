# frozen_string_literal: true

class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :graduation_work, null: false, foreign_key: true
      t.references :reviewer, null: false, foreign_key: { to_table: :employees }

      t.decimal :grade, null: false
      t.text :comment, null: false
      t.datetime :date_of_issue, null: false, default: Time.zone.now

      t.timestamps
    end
  end
end
