FactoryBot.define do
  factory :table do
    row_position { "MyString" }
    column_position { "MyString" }
    seating_chart { nil }
    student { nil }
  end
end
