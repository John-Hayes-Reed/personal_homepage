# @abstract a Service Object for filtering the parameters for Blog mass
#   assignment through a white list using StrongParameters.
class FilterBlogParams < BottledService
  att :params

  # Executes the Service Object.
  #
  # @raise [ActionController::ParameterMissing] if the required key is not
  #   present.
  #
  # @return [ActionController::Parameters]
  def call
    @params.require(:blog).permit(*allowed_params)
  end

  private

  # Provides a white list of parameters allowed for mass assignment to Blogs.
  #
  # @return [Array]
  def allowed_params
    %i[title body]
  end
end
