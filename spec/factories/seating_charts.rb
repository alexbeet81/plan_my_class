# == Schema Information
#
# Table name: seating_charts
#
#  id           :bigint           not null, primary key
#  columns      :integer
#  rows         :integer
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  classroom_id :bigint           not null
#
# Indexes
#
#  index_seating_charts_on_classroom_id  (classroom_id)
#
# Foreign Keys
#
#  fk_rails_...  (classroom_id => classrooms.id)
#
FactoryBot.define do
  factory :seating_chart do
    name { "MyString" }
    rows { 1 }
    columns { 1 }
    classroom { nil }
  end
end
