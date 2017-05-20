require 'rails_helper'

describe PackProjectTechnologies, type: :service do
  subject { described_class.call project: project }
  let!(:project) { build :project, technologies: {} }
  before do
    Project::TECHNOLOGY_ATTRIBUTES.each do |att|
      project.send "#{att}=", 'test input'
    end
  end

  it { expect { subject }.to change project, :technologies }
  Project::TECHNOLOGY_ATTRIBUTES.each do |att|
    it do
      subject
      expect(project.technologies[att]).to eq project.send att
    end
  end
end