# frozen_string_literal: true

class CreateKeyWords < ActiveRecord::Migration[6.1]
  def change
    create_table :key_words do |t|
      t.string :key_word, null: false, length: 200
      t.references :graduation_work, null: false, foreign_key: true
      t.timestamps
    end
  end
end
