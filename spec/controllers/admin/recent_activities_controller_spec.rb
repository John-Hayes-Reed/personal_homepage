require 'rails_helper'

describe Admin::RecentActivitiesController, type: :controller do
  let!(:admin) { find_or_create_admin }
  let!(:recent_activity1) { create :recent_activity }
  let!(:recent_activity2) { create :recent_activity }
  before { sign_in admin }

  describe 'GET #index' do
    it 'responds with success' do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status 200
    end

    it 'renders template' do
      get :index
      expect(response).to render_template 'index'
    end

    it 'loads all blogs' do
      get :index
      expect(assigns(:recent_activities)).to include recent_activity1
      expect(assigns(:recent_activities)).to include recent_activity2
    end
  end

  describe 'GET #show' do
    it 'responds with success' do
      get :show, params: { id: recent_activity1.id }
      expect(response).to be_success
      expect(response).to have_http_status 200
    end

    it 'renders template' do
      get :show, params: { id: recent_activity1.id }
      expect(response).to render_template 'show'
    end

    it 'loads desired activity' do
      get :show, params: { id: recent_activity1.id }
      expect(assigns(:recent_activity)).to eq recent_activity1
    end

    it 'responds with 404 when activity not found' do
      get :show, params: { id: recent_activity1.id + 10 }
      expect(response).to have_http_status 404
      expect(response).to render_template '404'
    end
  end

  describe 'GET #edit' do
    it 'responds with success' do
      get :edit, params: { id: recent_activity1.id }
      expect(response).to be_success
      expect(response).to have_http_status 200
    end

    it 'renders template' do
      get :edit, params: { id: recent_activity1.id }
      expect(response).to render_template 'edit'
    end

    it 'loads desired activity' do
      get :edit, params: { id: recent_activity1.id }
      expect(assigns(:recent_activity)).to eq recent_activity1
    end

    it 'responds with 404 when activity not found' do
      get :show, params: { id: recent_activity1.id + 10 }
      expect(response).to have_http_status 404
      expect(response).to render_template '404'
    end
  end

  describe 'POST #create' do
    it 'responds with redirect' do
      post :create, params: { recent_activity: attributes_for(:recent_activity) }
      expect(response).to be_redirect
      expect(response).to have_http_status 302
    end

    it 'successfully saves a new recent_activity' do
      post :create, params: { recent_activity: attributes_for(:recent_activity) }
      expect(assigns(:recent_activity)).to be_persisted
    end

    it 'rerenders on save error' do
      post :create, params: { recent_activity: attributes_for(:recent_activity).merge(title: nil) }
      expect(response).to render_template 'new'
    end
  end

  describe 'PUT #update' do
    it 'responds with redirect' do
      put :update, params: { id: recent_activity1.id,
                             recent_activity: attributes_for(:recent_activity).merge(title: 'title title') }
      expect(response).to be_redirect
      expect(response).to have_http_status 302
    end

    it 'successfully updates the correct recent_activity' do
      put :update, params: { id: recent_activity1.id,
                             recent_activity: attributes_for(:recent_activity).merge(title: 'title title') }
      expect(assigns(:recent_activity)).to be_persisted
      expect(RecentActivity.find(recent_activity1.id).title).to eq 'title title'
    end

    it 'rerenders on save error' do
      put :update, params: { id: recent_activity1.id,
                             recent_activity: attributes_for(:recent_activity).merge(title: nil) }
      expect(response).to render_template 'edit'
    end
  end

  describe 'DELETE #destroy' do
    it 'responds with redirect on successful deletion' do
      delete :destroy, params: { id: recent_activity1.id }
      expect(response).to be_redirect
      expect(response).to have_http_status 302
    end

    it 'successfully destroys the correct blog' do
      delete :destroy, params: { id: recent_activity1.id }
      expect(assigns(:recent_activity)).to be_destroyed
      expect { RecentActivity.find(recent_activity1.id) }
        .to raise_error ActiveRecord::RecordNotFound
    end
  end
end