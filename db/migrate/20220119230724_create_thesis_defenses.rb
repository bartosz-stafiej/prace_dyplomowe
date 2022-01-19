# frozen_string_literal: true

class CreateThesisDefenses < ActiveRecord::Migration[6.1]
  def change
    create_table :thesis_defenses do |t|
      t.string :defence_address, null: false
      t.decimal :final_grade, null: true
      t.datetime :date_of_defence, null: false, default: Time.zone.now

      t.references :evaluator, null: false, foreign_key: { to_table: :employees }
      t.references :author, null: false, foreign_key: { to_table: :students }
      t.references :graduation_work, null: false, foreign_key: true

      t.timestamps
    end
  end
end
