require 'rails_helper'

RSpec.describe SeatingChartsController, type: :controller do
  let(:teacher) { create(:teacher) }
  let(:classroom) { create(:classroom, teacher: teacher, rows: 10, columns: 10) }
  let(:seating_chart) { create(:seating_chart, classroom: classroom) }
  let(:valid_attributes) { { title: 'chart 1', rows: classroom.rows, columns: classroom.columns, classroom_id: classroom.id } }
  let(:invalid_attributes) { { title: '', rows: classroom.rows, columns: classroom.columns, classroom_id: classroom.id } }
  let(:large_attributes) { { title: 'large chart', rows: (classroom.rows + 1), columns: (classroom.columns + 1), classroom_id: classroom.id } }

  before do
    sign_in teacher
  end

  describe 'GET #new' do
    it 'renders a successful response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new SeatingChart' do
        expect {
          post :create, params: { seating_chart: valid_attributes }
        }.to change(SeatingChart, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new SeatingChart' do
        expect {
          post :create, params: { seating_chart: invalid_attributes }
        }.to change(SeatingChart, :count).by(0)
      end

      it 'renders the :new template' do
        post :create, params: { seating_chart: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end

    context 'with seating chart larger than classroom' do
      it 'does not create a new SeatingChart' do
        expect {
          post :create, params: { seating_chart: large_attributes }
        }.to change(SeatingChart, :count).by(0)
      end

      it 'renders the :new template' do
        post :create, params: { seating_chart: large_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    it 'renders a successful response' do
      get :edit, params: { id: seating_chart.id }
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      let(:new_attributes) { { title: 'updated chart' }}
    
      it 'renders a successful response' do
        patch :update, params: { id: seating_chart.id, seating_chart: new_attributes }
        expect(response).to be_successful
      end

      it 'updates seating_chart_title' do
        patch :update, params: { id: seating_chart.id, seating_chart: new_attributes }
        seating_chart.reload
        expect(seating_chart.title).to eq('updated chart')
      end
    end

    context 'with invalid parameters' do
      it 'renders a successful response' do
        patch :update, params: { id: seating_chart.id, seating_chart: invalid_attributes }
        expect(response).to be_successful
      end

      it 'renders the :edit template' do
        post :update, params: { id: seating_chart.id, seating_chart: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end

    context 'with seating chart larger than classroom' do
      let(:new_large_attributes) { { rows: (classroom.rows + 1) }}
      let(:original_rows) { seating_chart.rows}

      it 'does not update seating chart' do
        patch :update, params: { id: seating_chart.id, seating_chart: new_large_attributes }
        expect(seating_chart.rows).to eq(original_rows)
      end

      it 'renders the :edit template' do
        patch :update, params: { id: seating_chart.id, seating_chart: new_large_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:new_classroom) { create(:classroom, rows: 5, columns: 5) }
    let!(:seating_chart) { create(:seating_chart, rows: 5, columns: 5, classroom: new_classroom) }

    context 'with successful conditions' do
      it 'destroys the requested seating chart' do
        seating_chart = create(:seating_chart, rows: 5, columns: 5, classroom: new_classroom)
        expect {
          delete :destroy, params: { id: seating_chart.id }
        }.to change(SeatingChart, :count).by(-1)
      end
    end
    
    context 'with unsuccessful conditions' do
      before do
        allow_any_instance_of(SeatingChart).to receive(:destroy).and_return(false)
      end

      it 'does not delete the seating chart' do
        expect {
          delete :destroy, params: { id: seating_chart.id }
        }.not_to change(SeatingChart, :count)
      end
    end
  end
end