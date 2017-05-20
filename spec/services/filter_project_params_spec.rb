require 'rails_helper'

describe FilterProjectParams do
  subject { described_class.call params: params }

  context 'with valid parameters' do
    let(:params) do
      prms = ActionController::Parameters.new(
        project: attributes_for(:project)
      )
      prms[:project].delete('technologies')
      Project::TECHNOLOGY_ATTRIBUTES.each do |att|
        prms[:project][att] = 'a'
      end
      prms
    end

    it { is_expected.to be_a ActionController::Parameters }
    %i[title project_type url description]
      .push(*Project::TECHNOLOGY_ATTRIBUTES)
      .each do |key|

      it { is_expected.to include key.to_s }
    end
  end

  context 'with invalid parameters' do
    let(:params) do
      ActionController::Parameters.new(
        project: attributes_for(:project).merge(invalid: true)
      )
    end

    it do
      is_expected.to(satisfy { |res| !res.keys.map(&:to_s).include? 'invalid' })
    end
  end

  context 'with incorrect key' do
    let(:params) do
      ActionController::Parameters.new(
        illegal: attributes_for(:project)
      )
    end
    it { expect { subject }.to raise_error ActionController::ParameterMissing }
  end
end