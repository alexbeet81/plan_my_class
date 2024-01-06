class CreateSeatingCharts < ActiveRecord::Migration[7.1]
  def change
    create_table :seating_charts do |t|
      t.string :title
      t.integer :rows
      t.integer :columns
      t.references :classroom, null: false, foreign_key: true

      t.timestamps
    end
  end
end