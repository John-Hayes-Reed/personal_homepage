require 'rails_helper'

describe PersistRecentActivity, type: :service do
  subject { described_class.call recent_activity: recent_activity, params: params }

  context 'with new recent activity' do
    let!(:recent_activity) { BuildRecentActivity.call }

    context 'with valid params' do
      let(:params) do
        FilterRecentActivityParams.call(
          params: ActionController::Parameters.new(recent_activity: attributes_for(:recent_activity))
        )
      end

      it { is_expected.to be_truthy }
      it do
        subject
        expect(recent_activity).to be_persisted
      end
    end

    context 'with invalid params' do
      let(:params) do
        FilterRecentActivityParams.call(
          params: ActionController::Parameters.new(
            recent_activity: attributes_for(:recent_activity)
                                       .merge(title: nil)
          )
        )
      end
      it { is_expected.to be_falsey }
      it do
        subject
        expect(recent_activity).not_to be_persisted
      end
    end
  end

  context 'with existing recent_activity' do
    let!(:recent_activity) { create :recent_activity }
    context 'with valid parameters' do
      let(:params) do
        FilterRecentActivityParams.call(
          params: ActionController::Parameters.new(
            recent_activity: attributes_for(:recent_activity)
                                       .merge(title: 'new title')
          )
        )
      end
      it { is_expected.to be_truthy }
      it do
        subject
        expect(recent_activity.title).to eq 'new title'
      end
    end

    context 'with invalid parameters' do
      let(:params) do
        FilterRecentActivityParams.call(
          params: ActionController::Parameters.new(
            recent_activity: attributes_for(:recent_activity).merge(title: nil)
          )
        )
      end

      it { is_expected.to be_falsey }
    end
  end
end