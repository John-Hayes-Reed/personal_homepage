# @abstract the front controller for handling requests involved with projects.
class ProjectsController < ApplicationController

  # GET /projects
  def index
    find_projects
    find_gems
  end

  # GET /projects/1
  def show
    find_project
    initialize_markdown_renderer
  end

  private

  # Finds a list of projects from the database.
  #
  # @return [void]
  def find_projects
    @projects = Project.all
  end

  # Finds a list of open source gems using the RubygemsApi class.
  #
  # @note the contents of @gems instance variable are in JSON format.
  #
  # @return [void]
  def find_gems
    @gems = RubygemsApi.call :all
  end

  # Finds a single instance of Project from the database using an ID.
  #
  # @return [void]
  def find_project
    @project = InitializeProject.call id: params[:id]
  end

  # Initializes the Markdown Renderer.
  #
  # @return [void]
  def initialize_markdown_renderer
    @markdown = Redcarpet::Markdown.new Redcarpet::Render::HTML,
                                        autolink: true,
                                        fenced_code_blocks: true
  end
end
