class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def show
    find_project
  end

  private

  def find_project
    @project = Project.find(params[:id])
  end
end
