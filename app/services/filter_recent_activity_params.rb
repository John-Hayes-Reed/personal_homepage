# @abstract a Service Object to prepare the parameters for mass assignment to
#   recent activity models.
class FilterRecentActivityParams < BottledService
  att :params

  # Executes the Service Object.
  #
  # @return [ActionController::Parameters]
  def call
    @params.require(:recent_activity).permit(*allowed_params)
  end

  private

  def allowed_params
    %i[title comment parent_id]
  end
end
