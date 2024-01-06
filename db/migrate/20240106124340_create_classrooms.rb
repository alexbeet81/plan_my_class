class CreateClassrooms < ActiveRecord::Migration[7.1]
  def change
    create_table :classrooms do |t|
      t.string :name
      t.integer :rows
      t.integer :columns
      t.references :teacher, null: false, foreign_key: true

      t.timestamps
    end
  end
end
