
puts "Destroying old data"
Teacher.destroy_all
Classroom.destroy_all
SeatingChart.destroy_all
Student.destroy_all
Table.destroy_all

puts "Creating Teacher..."
teacher = Teacher.create!(email: 'alex@alex.com', password: '123456', password_confirmation: '123456')

puts "Created teacher #{teacher.id} - #{teacher.email}"

2.times do
  puts "Creating classroom..."
  classroom = Classroom.create!(name: Faker::Educator.course_name, rows: rand(3..5), columns: rand(3..5), teacher: teacher)

  puts "Created classroom #{classroom.id} - #{classroom.name}"

  puts "Creating seating charts..."
  2.times do |time|
    seating_chart = SeatingChart.create!(title: "Seating Chart #{time + 1}", rows: classroom.rows, columns: classroom.columns, classroom: classroom)
  
    puts " Created seating chart - #{seating_chart.id} - #{seating_chart.title}"

    puts "Creating tables and students..."
    ('A'..'Z').first(seating_chart.columns).each do |letter|
      (1..seating_chart.rows).to_a.each do |number|
        student = Student.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name) 
        table = Table.create!(row_position: letter, column_position: number, seating_chart: seating_chart, student: student)

        puts "Created student #{student.id} - #{student.first_name} #{student.last_name} at table #{table.row_position}#{table.column_position}"
      end
    end
  end
end