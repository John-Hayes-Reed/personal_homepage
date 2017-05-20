# @abstract a Service Object for initializing an already persisted Project
#   instance from the database and preparing it for output.
class InitializeProject < BottledService
  att :id

  # Executes the Service Object, Initializes a Project record by id, unpacks its
  #   technology attributes and adds necessary observer subscriptions.
  #
  # @raise [ActiveRecord::RecordNotFound] if a Project with an id value of @id
  #   does not exist.
  #
  # @return [Project]
  def call
    project = Project.find(@id)
    UnpackProjectTechnologies.call project: project
    project.add_subscription GenerateRecentActivity

    project
  end
end
