FactoryBot.define do
  factory :seating_chart do
    association :classroom
    title { Faker::Educator.course_name }
    rows { Faker::Number.between(from: 1, to: 10) }
    columns { Faker::Number.between(from: 1, to: 10) }
  end
end