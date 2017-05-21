require 'rails_helper'

describe PersistBlog, type: :service do
  subject { described_class.call blog: blog, params: params }

  context 'with new blog' do
    let!(:blog) { BuildBlog.call }

    context 'with valid params' do
      let(:params) do
        FilterBlogParams.call(params: ActionController::Parameters
                                               .new(blog:
                                                 {
                                                   title: 'title',
                                                   body: 'body'
                                                 }))
      end

      it { is_expected.to be_truthy }
      it do
        subject
        expect(blog).to be_persisted
      end
    end

    context 'with invalid params' do
      let(:params) do
        FilterBlogParams.call(params: ActionController::Parameters
                                             .new(blog:
                                               {
                                                 title: nil,
                                                 body: 'body'
                                               }))
      end

      it { is_expected.to be_falsey }
      it do
        subject
        expect(blog).not_to be_persisted
      end
    end
  end

  context 'with existing blog' do
    let!(:blog) do
      blog = create :blog
      InitializeBlog.call id: blog.id
    end

    context 'with valid parameters' do
      let(:params) do
        FilterBlogParams.call(params: ActionController::Parameters
                                               .new(blog:
                                                 {
                                                   title: 'new test title',
                                                   body: 'another body'
                                                 }
                                               ))
      end

      it { is_expected.to be_truthy }
      it do
        subject
        expect(blog.title).to eq 'new test title'
      end
    end

    context 'with invalid parameters' do
      let(:params) do
        FilterBlogParams.call(params: ActionController::Parameters
                                             .new(blog:
                                                      {
                                                          title: nil,
                                                          body: 'body'
                                                      }))
      end

      it { is_expected.to be_falsey }
    end
  end
end