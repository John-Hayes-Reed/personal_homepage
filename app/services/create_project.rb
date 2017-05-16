class CreateProject < BottledService

  att :title, String
  att :project_type, String
  att :url, String
  att :server, String
  att :database, String
  att :backend, String
  att :frontend, String
  att :templates, String
  att :app, String
  att :version_control, String
  att :language, String
  att :other, String
  att :description, String


  def call
    @project = Project.create(
      title: @title,
      url: @url,
      project_type: @project_type,
      server: @server,
      database: @database,
      backend: @backend,
      frontend: @frontend,
      templates: @templates,
      app: @app,
      version_control: @version_control,
      language: @language,
      other: @other,
      description: @description
    )
    if @project.errors.present?
      
    else

    end
    @project
  end

end
