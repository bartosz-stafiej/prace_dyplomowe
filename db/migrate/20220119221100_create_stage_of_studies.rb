# frozen_string_literal: true

class CreateStageOfStudies < ActiveRecord::Migration[6.1]
  def change
    create_table :stage_of_studies do |t|
      t.string :name, null: false, limit: 100
      t.timestamps
    end
  end
end
