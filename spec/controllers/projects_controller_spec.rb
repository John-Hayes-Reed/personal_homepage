require 'rails_helper'

describe ProjectsController, type: :controller do
  let!(:project1) { create :project }
  let!(:project2) { create :project }

  describe 'GET #index' do
    it 'responds with success' do
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
      expect(assigns(:projects)).to include project1
      expect(assigns(:gems)).not_to be_empty
    end
  end

  describe 'GET #show' do
    it 'responds with success' do
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

    it '404s on record not found' do
      get :show, params: { id: 0 }
      expect(response).to have_http_status 404
      expect(response).to render_template '404'
    end
  end
end