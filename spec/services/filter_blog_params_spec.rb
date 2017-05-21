require 'rails_helper'

describe FilterBlogParams, type: :service do
  subject { described_class.call params: params }

  context 'with valid parameters' do
    let(:params) do
      ActionController::Parameters.new(
        blog: { title: 'title', body: 'body'}
      )
    end

    it { is_expected.to be_a ActionController::Parameters }
    it { is_expected.to include 'title' }
    it { is_expected.to include 'body' }
  end

  context 'with invalid parameters' do
    let(:params) do
      ActionController::Parameters.new(
          blog: { title: 'title', body: 'body', invalid: 'invalid' }
      )
    end
    it { is_expected.to include 'title' }
    it { is_expected.to include 'body' }
    it { is_expected.not_to include 'invalid' }
  end

  context 'with incorrect key' do
    let(:params) do
      ActionController::Parameters.new(
        illegal_key: { title: 'title', body: 'body' }
      )
    end
    it { expect { subject }.to raise_error ActionController::ParameterMissing }
  end
end