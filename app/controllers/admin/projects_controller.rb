# module Admin
  # @abstract The admin namespace controller for handling Projects.
  # app/controllers/admin/projects_controller.rb
  class Admin::ProjectsController < ApplicationController
    before_action :authenticate_admin!

    # GET /admin/projects
    def index
      @projects = Project.all
    end

    # GET /admin/projects/1
    def show
      find_project
      initialize_markdown_renderer
    end

    # GET /admin/projects/new
    def new
      build_project
    end

    # POST /admin/projects
    def create
      build_project
      if persist_project
        redirect_to admin_project_path(@project)
      else
        render :new
      end
    end

    # GET /admin/projects/edit
    def edit
      find_project
    end

    # PATCH /admin/projects/1
    # PUT /admin/projects/1
    def update
      find_project
      if persist_project
        redirect_to admin_project_path(@project)
      else
        render :edit
      end
    end

    # DELETE /admin/projects/1
    def destroy
      find_project.destroy
      redirect_to admin_projects_path
    end

    private

    # Builds a new instance of the Project model.
    #
    # @return [Project]
    def build_project
      @project = BuildProject.call
    end

    # Finds a Project record from the database and defines it with the @project
    #   instance variable
    def find_project
      @project = InitializeProject.call id: params[:id]
    end

    # Persists a Project to the database with the parameters provided from the
    #   user input.
    #
    # @return [true] if the Project successfully saves.
    # @return [false] if the Project fails to save.
    def persist_project
      PersistProject.call project: @project, params: project_params
    end

    # Filters the parameters sent using StrongParameters and returns a
    #   whitelisted set of parameters for saving instances of Project.
    #
    # @return [ActionController::Parameters]
    def project_params
      FilterProjectParams.call params: params
    end

    # Defines the markdown renderer with the @markdown instance variable
    #
    # @return [void]
    # @todo Move the below logic to a Service Object.
    def initialize_markdown_renderer
      @markdown = Redcarpet::Markdown.new Redcarpet::Render::HTML,
                                          autolink: true,
                                          fenced_code_blocks: true
    end
  end
# end
