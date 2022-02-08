class RemoveSupervisorReferenceToTableUsers < ActiveRecord::Migration[6.1]
  def change
    remove_reference :graduation_works, :supervisor, null: false
    add_reference :graduation_works, :supervisor, foreign_key: { to_table: :users }
  end
end
