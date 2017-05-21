# @abstract Service Object for initializing instances of Blog from DB records
#   and subscribing the required observers to it.
class InitializeBlog < BottledService
  att :id

  # Executes the Service Object logic. First Finds a Blog record with an id,
  #   then adds the GenerateRecentActivity observer to its subscriptions list.
  #
  # @raise [ActiveRecord::RecordNotFound] if no blog with the given id exists.
  # @return [Blog]
  def call
    blog = Blog.find(@id)
    blog.add_subscription GenerateRecentActivity

    blog
  end
end
