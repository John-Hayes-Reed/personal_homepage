require 'rails_helper'

describe UnpackProjectTechnologies, type: :service do
  subject { described_class.call project: project }
  let(:project) { build :project }

  Project::TECHNOLOGY_ATTRIBUTES.each do |att|
    it { expect { subject }.to change project, att }
    it do
      subject
      expect(project.send(att)).to eq project.technologies[att.to_s]
    end
  end
end