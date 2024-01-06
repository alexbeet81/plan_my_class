require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  let(:teacher) { create(:teacher) }
  let(:student) { create(:student) }
  let(:valid_attributes) { { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name }}
  let(:invalid_attributes) { { first_name: '', last_name: ''} }

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
      it 'creates a new classroom' do
        expect {
          post :create, params: { student: valid_attributes }
        }.to change(Student, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Classroom' do
        expect {
          post :create, params: { student: invalid_attributes }
        }.to change(Student, :count).by(0)
      end

      it 'renders the :new template' do
        post :create, params: { student: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    it 'renders a successful response' do
      get :edit, params: { id: student.id }
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      let(:new_attributes) { { first_name: 'Alex' }}
      it 'updates a student' do
        patch :update, params: { id: student.id, student: new_attributes }
        student.reload
        expect(student.first_name).to eq('Alex')
      end
    end

    context 'with invalid parameters' do
      let(:new_invalid_attributes) { { first_name: '' }}
      it 'does not update a student' do
        patch :update, params: { id: student.id, student: new_invalid_attributes }
        expect(response).to be_successful
      end

      it 'renders the :edit template' do
        post :update, params: { id: student.id, student: new_invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with successful conditions' do
      it 'destroys the requested student' do
        student = create(:student)
        expect {
          delete :destroy, params: { id: student.id }
        }.to change(Student, :count).by(-1)
      end
    end
    
    context 'with unsuccessful conditions' do
      let!(:student) { create(:student) }

      before do
        allow_any_instance_of(Student).to receive(:destroy).and_return(false)
      end

      it 'does not delete the student' do
        expect {
          delete :destroy, params: { id: student.id }
        }.not_to change(Student, :count)
      end
    end
  end
end