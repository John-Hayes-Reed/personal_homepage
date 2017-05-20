require 'rails_helper'

describe PersistProject, type: :service do
  subject { described_class.call project: project, params: params }

  context 'with new project' do
    let!(:project) { BuildProject.call }

    context 'with valid params' do
      let(:params) do
        prms = ActionController::Parameters.new(
          project: attributes_for(:project)
        )
        prms[:project].delete('technologies')
        Project::TECHNOLOGY_ATTRIBUTES.each do |att|
          prms[:project][att] = 'a'
        end
        FilterProjectParams.call params: prms
      end

      it { is_expected.to be_truthy }
      Project::TECHNOLOGY_ATTRIBUTES.each do |att|
        it do
          is_expected.to satisfy do |_|
            project.technologies[att.to_s] == project.send(att)
          end
        end
      end
    end

    context 'with invalid params' do
      let(:params) do
        prms = ActionController::Parameters.new(
          project: attributes_for(:project)
        )
        prms[:project].delete('technologies')
        Project::TECHNOLOGY_ATTRIBUTES.each do |att|
          prms[:project][att] = 'a'
        end
        prms[:project][:title] = nil
        FilterProjectParams.call params: prms
      end

      it { is_expected.to be_falsey }
    end

    context 'with no params' do
      it do
        expect do
          described_class.call project: project
        end.to raise_error ArgumentError
      end
    end
  end

  context 'with existing product' do
    let!(:project) do
      project = create :project
      InitializeProject.call id: project.id
    end

    context 'with valid parameters' do
      let(:params) do
        prms = ActionController::Parameters.new(
            project: attributes_for(:project).merge(title: 'new title')
        )
        prms[:project].delete('technologies')
        Project::TECHNOLOGY_ATTRIBUTES.each do |att|
          prms[:project][att] = 'a'
        end
        FilterProjectParams.call params: prms
      end

      it { is_expected.to be_truthy }
      it { is_expected.to(satisfy { |_| project.title == 'new title' }) }
    end

    context 'with invalid params' do
      let(:params) do
        prms = ActionController::Parameters.new(
            project: attributes_for(:project)
        )
        prms[:project].delete('technologies')
        Project::TECHNOLOGY_ATTRIBUTES.each do |att|
          prms[:project][att] = 'a'
        end
        prms[:project][:title] = nil
        FilterProjectParams.call params: prms
      end

      it { is_expected.to be_falsey }
    end
  end
end