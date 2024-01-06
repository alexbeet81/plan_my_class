require 'rails_helper'

RSpec.describe SeatingChartsController, type: :controller do
  let(:teacher) { create(:teacher) }
  let(:classroom) { create(:classroom, teacher: teacher) }
  let(:seating_chart) { create(:seating_chart, classroom: classroom) }

  before do
    sign_in teacher
  end

  describe 'index' do
    let!(:seating_charts) do
      create_list(:seating_chart, 3, classroom: classroom)
    end
    
    it 'returns a list of seating_charts' do
      get :index
      expect(response).to be_successful
      expect(assigns(:seating_charts)).to match_array(seating_charts)
    end
  end

  # Add tests for show, new, create, edit, update, destroy...
end