require 'rails_helper'

describe BlogsController, type: :controller do
  let!(:blog1) { create :blog }
  let!(:blog2) { create :blog }

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

    it 'loads all blogs' do
      get :index
      expect(assigns(:blogs)).to include blog1
      expect(assigns(:blogs)).to include blog2
    end
  end

  describe 'GET #show' do
    it 'responds with success' do
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

    it '404s on record not found' do
      get :show, params: { id: 0 }
      expect(response).to have_http_status 404
      expect(response).to render_template '404'
    end
  end
end