# @abstract Service Object for opening up a project models serialized
#   technologies attributes and setting seperate instance variables.
class UnpackProjectTechnologies < BottledService
  att :project, Project

  # Executes the Service Object logic and initializes technology fields for an
  #   instance of Project.
  #
  # @return [void]
  def call
    @project.technologies ||= {}
    Project::TECHNOLOGY_ATTRIBUTES.each do |tech|
      if @project.technologies[tech.to_s].blank?
        @project.send(:instance_variable_set, :"@#{tech}", nil)
      else
        @project.send(:instance_variable_set,
                      :"@#{tech}",
                      @project.technologies[tech.to_s])
      end
    end
  end
end
