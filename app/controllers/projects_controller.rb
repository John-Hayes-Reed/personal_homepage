class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def show
    find_project
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, fenced_code_blocks: true)
  end

  private

  def find_project
    @project = Project.find(params[:id])
  end
end
