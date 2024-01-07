# == Schema Information
#
# Table name: desks
#
#  id               :bigint           not null, primary key
#  column_position  :string
#  row_position     :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  seating_chart_id :bigint           not null
#  student_id       :bigint           not null
#
# Indexes
#
#  index_desks_on_seating_chart_id  (seating_chart_id)
#  index_desks_on_student_id        (student_id)
#
# Foreign Keys
#
#  fk_rails_...  (seating_chart_id => seating_charts.id)
#  fk_rails_...  (student_id => students.id)
#
require 'rails_helper'

RSpec.describe Desk, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
