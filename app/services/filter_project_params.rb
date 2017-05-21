# @abstract A Service Object for handling the Strong Parameters filtering for
#   Project model mass assignment.
class FilterProjectParams < BottledService
  att :params

  # Executes the Service Object.
  #
  # @raise [ActionController::ParameterMissing] if the required key is not
  #   present.
  #
  # @return [ActionController::Parameters]
  def call
    @params.require(:project).permit(*allowed_params)
  end

  private

  # Provides a list of the allowed parameters for Project writes.
  #
  # @return [Array]
  def allowed_params
    %i[
      id
      title
      project_type
      url
      description
    ].push(*Project::TECHNOLOGY_ATTRIBUTES)
  end
end
