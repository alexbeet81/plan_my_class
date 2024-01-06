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
require 'rails_helper'

RSpec.describe SeatingChart, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
