class UpdateProject < BottledService

  att :project, Project
  att :title, String
  att :url, String
  att :project_type, String
  att :description, String


  def call
    @project.update(
      title: @title,
      url: @url,
      project_type: @project_type,
      description: @description
    )
    if @project.errors.present?
    else
    end
    @project
  end

end
