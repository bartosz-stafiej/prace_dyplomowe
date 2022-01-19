# frozen_string_literal: true

class CreateCollege < ActiveRecord::Migration[6.1]
  def change
    create_table :colleges do |t|
      t.string :field_of_study, null: false
      t.string :faculty, null: false

      t.timestamps
    end
  end
end
