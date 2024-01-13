class AddCurrentSeatingChartToClassroom < ActiveRecord::Migration[7.1]
  def change
    add_reference :classrooms, :current_seating_chart, foreign_key: { to_table: :seating_charts }

    Classroom.find_each do |classroom|
      current_seating_chart = classroom.seating_charts&.first
      classroom.update(current_seating_chart: current_seating_chart) if current_seating_chart
    end
  end
end