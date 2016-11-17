class Admin::ProjectsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @projects = Project.all
  end

  def show
    find_project
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, fenced_code_blocks: true)
  end

  def new
    @project = Project.new
  end

  def create
    @project = CreateProject.(project_params)
    render :new and return if @project.errors.present?
    redirect_to admin_project_path(@project)
  end

  def edit
    find_project
  end

  def update
    @project = UpdateProject.(project_params.merge({project: find_project}))
    render :edit and return if @project.errors.present?
    redirect_to admin_project_path(@project)
  end

  def destroy
    find_project.destroy
    redirect_to admin_projects_path
  end

  private

  def find_project
    @project = Project.find(params[:id])
  end

  def project_params
    {}.tap do |prms|
      params.require(:project).permit(:title, :project_type, :url, :description).each do |k,v|
        prms["#{k}".to_sym] = v
      end
    end
  end
end
