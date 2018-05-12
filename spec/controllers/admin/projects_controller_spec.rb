require 'rails_helper'

describe Admin::ProjectsController, type: :controller do
  let!(:admin) { find_or_create_admin }
  let!(:project1) { create :project }
  let!(:project2) { create :project }
  before { sign_in admin }
  describe 'GET #index' do
    it 'responds successfully with a 200' do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status 200
    end

    it 'successfully renders template' do
      get :index
      expect(response).to render_template 'index'
    end

    it 'loads all projects' do
      get :index
      expect(assigns(:projects)).to include project1
      expect(assigns(:projects)).to include project2
    end
  end

  describe 'GET #show' do
    it 'responds successfully with a 200' do
      get :show, params: { id: project1.id }
      expect(response).to be_success
      expect(response).to have_http_status 200
    end

    it 'renders template' do
      get :show, params: { id: project1.id }
      expect(response).to render_template 'show'
    end

    it 'loads desired project' do
      get :show, params: { id: project1.id }
      expect(assigns(:project)).to eq project1
    end
  end

  describe 'GET #edit' do
    it 'responds with success' do
      get :edit, params: { id: project1.id }
      expect(response).to be_success
      expect(response).to have_http_status 200
    end

    it 'responds with 404 and renders not found template on not found' do
      get :edit, params: { id: project1.id + 10 }
      expect(response).to have_http_status 404
      expect(response).to render_template '404'
    end

    it 'renders template' do
      get :edit, params: { id: project1.id }
      expect(response).to render_template 'edit'
    end

    it 'loads desired project' do
      get :edit, params: { id: project1.id }
      expect(assigns(:project)).to eq project1
    end
  end

  describe 'POST #create' do
    it 'responds with redirect on successful save' do
      post :create, params: { project: attributes_for(:project) }
      expect(response).to be_redirect
      expect(response).to have_http_status 302
    end

    it 'successfully saves a new project' do
      post :create, params: { project: attributes_for(:project) }
      expect(assigns(:project)).to be_persisted
    end

    it 'rerenders on save error' do
      post :create, params: { project: attributes_for(:project).merge(title: nil) }
      expect(response).to render_template 'new'
    end

    it 'does not save a new project instance on validation error' do
      post :create, params: { project: attributes_for(:project).merge(title: nil) }
      expect(assigns(:project)).to be_a_new Project
    end
  end

  describe 'PATCH #update' do
    it 'responds with redirect on successful save' do
      put :update, params: { id: project1.id, project: attributes_for(:project).merge(title: 'new title', id: project1.id) }
      expect(response).to be_redirect
      expect(response).to have_http_status 302
    end

    it 'successfully updates the correct project' do
      put :update, params: { id: project1.id, project: attributes_for(:project).merge(title: 'new title', id: project1.id) }
      expect(assigns(:project)).to be_persisted
      expect(Project.find(project1.id).title).to eq 'new title'
    end

    it 'rerenders on save error' do
      put :update, params: { id: project1.id, project: attributes_for(:project).merge(title: nil, id: project1.id) }
      expect(response).to render_template 'edit'
    end

    it 'does not save the project instance on validation error' do
      put :update, params: { id: project1.id, project: attributes_for(:project).merge(title: nil, id: project1.id) }
      expect(project1.title).not_to eq 'new title'
    end
  end

  describe 'DELETE #destroy' do
    it 'responds with redirect on successful deletion' do
      delete :destroy, params: { id: project1.id }
      expect(response).to be_redirect
      expect(response).to have_http_status 302
    end

    it 'successfully destroys the correct project' do
      delete :destroy, params: { id: project1.id }
      expect(assigns(:project)).to be_destroyed
      expect { Project.find(project1.id) }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end