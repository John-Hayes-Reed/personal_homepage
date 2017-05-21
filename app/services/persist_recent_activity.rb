class PersistRecentActivity < BottledService

  att :recent_activity, RecentActivity
  att :params
  

  def call
    @recent_activity.attributes = @params
    @recent_activity.save
  end

end
