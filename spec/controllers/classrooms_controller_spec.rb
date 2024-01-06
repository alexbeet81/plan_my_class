require 'rails_helper'

RSpec.describe ClassroomsController, type: :controller do
  let(:teacher) { create(:teacher) }
  let(:classroom) { create(:classroom) }
  let(:valid_attributes) { { name: 'Math 101', rows: 5, columns: 5, teacher_id: teacher.id } }
  let(:invalid_attributes) { { name: '', rows: 5, columns: 5, teacher_id: teacher.id } }
  let(:zero_classroom) { { name: 'zero classrom', rows: 0, columns: 0, teacher_id: teacher.id} }

  before do
    sign_in teacher
  end

  describe 'GET #index' do
    it 'renders a successful response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'renders a successful response' do
      get :show, params: { id: classroom.id}
      expect(response).to be_successful
    end
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
          post :create, params: { classroom: valid_attributes }
        }.to change(Classroom, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Classroom' do
        expect {
          post :create, params: { classroom: invalid_attributes }
        }.to change(Classroom, :count).by(0)
      end

      it 'renders the :new template' do
        post :create, params: { classroom: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end

    context 'with classroom size of zero' do
      it 'does not create a new classroom' do
        expect {
          post :create, params: { classroom: zero_classroom }
        }.to change(Classroom, :count).by(0)
      end
    end
  end

  describe 'GET #edit' do
    it 'renders a successful response' do
      get :edit
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      let(:new_attributes) { { name: 'English 101' }}
      it 'updates a classroom' do
        patch :update, params: { id: classroom.id, classroom: new_attributes }
        classroom.reload
        expect(classroom.name).to eq('English 101')
      end
    end

    context 'with invalid parameters' do
      it 'renders a successful response' do
        patch :update, params: { id: classroom.id, classroom: invalid_attributes }
        expect(response).to be_successful
      end

      it 'renders the :edit template' do
        post :update, params: { id: classroom.id, classroom: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end

    context 'with classroom size of zero' do
      it 'renders a successful response' do
        patch :update, params: { id: classroom.id, classroom: zero_classroom }
        expect(response).to render_template(:edit)
      end

      it 'renders the :edit template' do
        post :update, params: { id: classroom.id, classroom: zero_classroom }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with successful conditions' do
      it 'destroys the requested classroom' do
        classroom = create(:classroom, teacher: teacher)
        expect {
          delete :destroy, params: { id: classroom.id }
        }.to change(Classroom, :count).by(-1)
      end
  
      it 'redirects to the classrooms list' do
        delete :destroy, params: { id: classroom.id }
        expect(response).to redirect_to(classrooms_url)
      end
    end
    
    context 'with unsuccessful conditions' do
      let!(:classroom) { create(:classroom) }

      before do
        allow_any_instance_of(Classroom).to receive(:destroy).and_return(false)
      end

      it 'does not delete the classroom' do
        expect {
          delete :destroy, params: { id: classroom.id }
        }.not_to change(Classroom, :count)
      end
  
      it 'redirects to the classroom show page' do
        delete :destroy, params: { id: classroom.id }
        expect(response).to redirect_to(classroom_path(classroom))
      end
    end
  end
end