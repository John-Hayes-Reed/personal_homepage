require 'rails_helper'

describe BuildProject do
  subject { described_class.call }
  it { is_expected.to be_a Project }
  it { is_expected.to respond_to :subscriptions }
  Project::TECHNOLOGY_ATTRIBUTES.each do |att|
    it { is_expected.to respond_to att }
    it { is_expected.to(satisfy { |res| res.send(att).blank? }) }
    it { is_expected.to(satisfy { |res| !res.subscriptions.empty? }) }
  end
end