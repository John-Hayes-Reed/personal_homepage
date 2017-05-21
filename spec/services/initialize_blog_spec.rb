require 'rails_helper'

describe InitializeBlog, type: :service do
  subject { described_class.call id: id }
  let!(:blog) { create :blog }
  context 'with a correct id' do
    let(:id) { blog.id }
    it { is_expected.to be_a Blog }
    it { is_expected.to be_persisted }
    it { is_expected.to respond_to :subscriptions }
    it { expect(subject.subscriptions).not_to be_empty }
  end
end
