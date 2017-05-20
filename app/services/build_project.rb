# A Service Object for initializing and preparing a new instance of the Project
# model.
class BuildProject < BottledService

  # Executes the Service Object logic, Builds a new instance of Project and
  #   then adds the required observers.
  #
  # @return [Project]
  def call
    project = Project.new
    UnpackProjectTechnologies.call project: project
    project.add_subscription GenerateRecentActivity

    project
  end

end
