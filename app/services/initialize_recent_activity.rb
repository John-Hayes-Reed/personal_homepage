# @abstract a Service Object for initializing instances of RecentActivity from
#   database records.
class InitializeRecentActivity < BottledService
  att :id

  def call
    RecentActivity.find(@id)
  end
end
