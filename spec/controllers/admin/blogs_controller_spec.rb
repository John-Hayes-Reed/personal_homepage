require 'rails_helper'

describe Admin::BlogsController, type: :controller do
  let!(:admin) { create :admin }
  let!(:blog1) { create :blog }
  let!(:blog2) { create :blog }
  before { sign_in admin }

  describe 'GET #index' do
    it 'responds successfully with a 200' do
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
      expect(assigns(:blogs)).to include blog1
      expect(assigns(:blogs)).to include blog2
    end
  end

  describe 'GET #show' do
    it 'responds successfully with a 200' do
      get :show, params: { id: blog1.id }
      expect(response).to be_success
      expect(response).to have_http_status 200
    end

    it 'renders template' do
      get :show, params: { id: blog1.id }
      expect(response).to render_template 'show'
    end

    it 'loads desired blog' do
      get :show, params: { id: blog1.id }
      expect(assigns(:blog)).to eq blog1
    end

    it 'responds with 404 and renders not found template not found' do
      get :show, params: { id: blog1.id + 10 }
      expect(response).to have_http_status 404
      expect(response).to render_template '404'
    end
  end

  describe 'GET #edit' do
    it 'responds with success' do
      get :edit, params: { id: blog1.id }
      expect(response).to be_success
      expect(response).to have_http_status 200
    end

    it 'renders template' do
      get :edit, params: { id: blog1.id }
      expect(response).to render_template 'edit'
    end

    it 'loads desired blog' do
      get :edit, params: { id: blog1.id }
      expect(assigns(:blog)).to eq blog1
    end

    it 'responds with 404 and render not found template on not found' do
      get :edit, params: { id: blog1.id + 10 }
      expect(response).to have_http_status 404
      expect(response).to render_template '404'
    end
  end

  describe 'POST #create' do
    it 'responds with redirect on successful save' do
      post :create, params: { blog: attributes_for(:blog) }
      expect(response).to be_redirect
      expect(response).to have_http_status 302
    end

    it 'successfully saves a new blog' do
      post :create, params: { blog: attributes_for(:blog) }
      expect(assigns(:blog)).to be_persisted
    end

    it 'rerenders on save error' do
      post :create, params: { blog: attributes_for(:blog).merge(title: nil) }
      expect(response).to render_template 'new'
    end

    it 'does not save a new project instance on validation error' do
      post :create, params: { blog: attributes_for(:blog).merge(title: nil) }
      expect(assigns(:blog)).to be_a_new Blog
    end
  end

  describe 'PUT #update' do
    it 'responds with redirect on successful save' do
      put :update, params: { id: blog1.id,
                             blog: attributes_for(:blog)
                                   .merge(title: 'new title', id: blog1.id) }
      expect(response).to be_redirect
      expect(response).to have_http_status 302
    end

    it 'successfully updates the correct blog' do
      put :update, params: { id: blog1.id,
                             blog: attributes_for(:blog)
                                   .merge(title: 'new title', id: blog1.id) }
      expect(assigns(:blog)).to be_persisted
      expect(Blog.find(blog1.id).title).to eq 'new title'
    end

    it 'rerenders on save error' do
      put :update, params: { id: blog1.id,
                             blog: attributes_for(:blog)
                                   .merge(title: nil, id: blog1.id) }
      expect(response).to render_template 'edit'
    end
  end

  describe 'DELETE #destroy' do
    it 'responds with redirect on successful deletion' do
      delete :destroy, params: { id: blog1.id }
      expect(response).to be_redirect
      expect(response).to have_http_status 302
    end

    it 'successfully destroys the correct blog' do
      delete :destroy, params: { id: blog1.id }
      expect(assigns(:blog)).to be_destroyed
      expect { Blog.find(blog1.id) }
        .to raise_error ActiveRecord::RecordNotFound
    end
  end
end