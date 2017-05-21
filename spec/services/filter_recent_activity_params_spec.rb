require 'rails_helper'

describe FilterRecentActivityParams, type: :service do
  subject { described_class.call params: params }

  context 'with valid params' do
    let(:params) do
      ActionController::Parameters.new(
        recent_activity: { title: 'title', comment: 'comment', parent_id: 1 }
      )
    end

    it { is_expected.to be_a ActionController::Parameters }
    it { is_expected.to include 'title' }
    it { is_expected.to include 'comment' }
    it { is_expected.to include 'parent_id' }
  end

  context 'with invalid parameters' do
    let(:params) do
      ActionController::Parameters.new(
        recent_activity: { title: 'title', comment: 'comment', invalid: 'invalid' }
      )
    end

    it { is_expected.to include 'title' }
    it { is_expected.to include 'comment' }
    it { is_expected.not_to include 'invalid' }
  end

  context 'with incorrect key' do
    let(:params) do
      ActionController::Parameters.new(
          wong_key: { title: 'title', comment: 'comment', parent_id: 1 }
      )
    end

    it { expect { subject}.to raise_error ActionController::ParameterMissing }
  end
end