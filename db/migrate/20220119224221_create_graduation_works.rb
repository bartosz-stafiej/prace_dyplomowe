# frozen_string_literal: true

class CreateGraduationWorks < ActiveRecord::Migration[6.1]
  def change
    create_table :graduation_works do |t|
      t.string :title, null: true
      t.string :topic, null: false
      t.datetime :date_of_submission, null: false

      t.references :stage_of_study, null: false, foreign_key: true
      t.references :supervisor, null: true, foreign_key: { to_table: :employees }

      t.timestamps
    end
  end
end
