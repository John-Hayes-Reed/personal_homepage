# @abstract a Service Object for persisting instances of RecentActivity to the
#   database.
class PersistRecentActivity < BottledService

  att :recent_activity, RecentActivity
  att :params

  def call
    @recent_activity.attributes = @params
    @recent_activity.save
  end

end
