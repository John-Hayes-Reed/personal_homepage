require 'rails_helper'

describe InitializeRecentActivity, type: :service do
  subject { described_class.call id: id }
  let!(:recent_activity) { create :recent_activity }

  context 'with a correct id' do
    let(:id) { recent_activity.id }
    it { is_expected.to be_a RecentActivity }
    it { is_expected.to be_persisted }
  end

  context 'with an incorrect id' do
    let(:id) { recent_activity.id + 10 }
    it { expect { subject }.to raise_error ActiveRecord::RecordNotFound }
  end
end