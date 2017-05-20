require 'rails_helper'

describe InitializeProject, type: :service do
  subject { described_class.call id: id }
  let!(:project) { create :project }
  context 'with a correct id' do
    let(:id) { project.id }
    it { is_expected.to be_a Project }
    Project::TECHNOLOGY_ATTRIBUTES.each do |att|
      it { is_expected.to respond_to att }
      it do
        is_expected.to(satisfy { |res| res.send(att.to_s) == res.technologies[att.to_s] })
      end
    end
    it { is_expected.to respond_to :subscriptions }
    it { is_expected.to(satisfy { |res| !res.subscriptions.empty? }) }
  end

  context 'with an incorrect id' do
    let(:id) { nil }
    it { expect { subject }.to raise_error ActiveRecord::RecordNotFound }
  end
end