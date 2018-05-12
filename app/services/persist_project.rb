# @abstract a Service Object for persisting instances of Product
#   to the database.
class PersistProject < BottledService
  att :project, Project
  att :params

  # Saves an instance of Project to the database and notifies any observers
  #   of the change.
  #
  # @return [true] if the project instance saves.
  # @return [false] if the project instance is not saved.
  def call
    @project.attributes = params
    PackProjectTechnologies.call project: @project

    return false unless @project.save
    @project.modified
    @project.publish
    true
  end
end
