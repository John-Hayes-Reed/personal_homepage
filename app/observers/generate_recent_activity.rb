# Observer class for creating RecentActivity records.
class GenerateRecentActivity
  include BottledObserver

  def call
    return unless @subscription&.is_a?(Project) || @subscription&.is_a?(Blog)
    recent_activity = BuildRecentActivity.call parent: @subscription
    params = {
      title: define_title,
      comment: define_comment
    }
    PersistRecentActivity.call recent_activity: recent_activity,
                               params: params
  end

  private

  def define_title
    if @subscription.is_a?(Project) && @subscription.project_type.gem?
      "#{@subscription.title.capitalize} gem updated"
    elsif @subscription.is_a? Blog
      'New blog post!'
    end
  end

  def define_comment
    if @subscription.is_a?(Project) && @subscription.project_type.gem?
      "A new version of #{@subscription.title.downcase} has been released"
    elsif @subscription.is_a?(Blog)
      @subscription.title
    end
  end
end
