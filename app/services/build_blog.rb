# @abstract Service Object for building new instances of blogs and subscribing
#   the required observers to it.
class BuildBlog < BottledService
  # Exectues the Service Object logic. First creates a new empty instance of
  #   Blog, then adds the GenerateRecentActivity observer to its subscriptions
  #   list.
  #
  # @return [Blog]
  def call
    blog = Blog.new
    blog.add_subscription GenerateRecentActivity

    blog
  end
end
