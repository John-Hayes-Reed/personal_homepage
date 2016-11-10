class CreateProject < BottledService

  att :title, String
  att :project_type, String
  att :url, String
  att :description, String


  def call
    @project = Project.create(
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
