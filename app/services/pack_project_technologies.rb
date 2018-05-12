# @abstract Service Object for taking a Project instances seperate technology
#   attributes and packing them into the serialized technologies column.
class PackProjectTechnologies < BottledService
  att :project, Project

  # Executes the Service Object's logic and sets a Projects instances
  #   technologies column using the individual attributes.
  #
  # @return [void]
  def call
    @project.technologies ||= {}
    Project::TECHNOLOGY_ATTRIBUTES.each do |tech|
      @project.technologies[:"#{tech}"] = @project.send(:"#{tech}")
    end
  end
end
