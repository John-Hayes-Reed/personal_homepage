class ProjectsController < ApplicationController

  def index
    @projects = Project.all
    @gems = RubygemsApi.call :all
  end

  def show
    find_project
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, fenced_code_blocks: true)
  rescue ActiveRecord::RecordNotFound => e
    redirect_to projects_path, alert: t('project_not_found')
  end

  private

  def find_project
    @project = Project.find(params[:id])
  end
end
