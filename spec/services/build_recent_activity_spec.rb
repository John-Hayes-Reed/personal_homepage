require 'rails_helper'

shared_examples 'a new activity' do
  it { is_expected.to be_a RecentActivity }
  it { is_expected.not_to be_persisted }
end

describe BuildRecentActivity, type: :service do
  subject { described_class.call(params) }

  context 'with parent' do
    context 'type project' do
      let!(:project) { create :project }
      let(:params) { { parent: project } }
      include_examples 'a new activity'
      it { expect(subject.parent).to eq project }
    end

    context 'type blog' do
      let!(:blog) { create :blog }
      let(:params) { { parent: blog } }
      include_examples 'a new activity'
      it { expect(subject.parent).to eq blog }
    end
  end

  context 'without parent' do
    let(:params) { {} }
    include_examples 'a new activity'
    it { expect(subject.parent).to be_nil }
  end
end