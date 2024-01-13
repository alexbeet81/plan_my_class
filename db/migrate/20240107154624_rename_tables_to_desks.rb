class RenameTablesToDesks < ActiveRecord::Migration[7.1]
  def change
    rename_table :tables, :desks
  end
end