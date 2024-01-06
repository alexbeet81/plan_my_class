FactoryBot.define do
  factory :classroom do
    association :teacher
    name { Faker::Educator.course_name }
    rows { Faker::Number.between(from: 1, to: 10) }
    columns { Faker::Number.between(from: 1, to: 10) }
  end
end