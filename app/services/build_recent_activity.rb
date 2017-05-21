# @abstract a Service Object to build new RecentActivity instances.
class BuildRecentActivity < BottledService

  att :parent

  def call
    if @parent.present?
      @parent.recent_activities.build
    else
      RecentActivity.new
    end
  end

end
