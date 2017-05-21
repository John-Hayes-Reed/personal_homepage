require 'rails_helper'

describe GenerateRecentActivity, type: :observer do
  subject { observer.call }

  let(:observer) do
    publisher.add_subscription described_class
    publisher.subscriptions.first
  end

  context 'subscribed to project' do
    let(:publisher) { create :project }

    it do
      subject
      expect(publisher.recent_activities).not_to be_empty
    end
  end

  context 'subscribed to blog' do
    let(:publisher) { create :blog }

    it do
      subject
      expect(publisher.recent_activities).not_to be_empty
    end
  end

end