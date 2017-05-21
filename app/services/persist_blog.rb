# @abstract a Service Object for persisting instances of Blog to the database
#   with the given params.
class PersistBlog < BottledService
  att :blog, Blog
  att :params

  # Executes the Service Object. Assigns the Blogs attributes, attempts a save,
  #   and publishes to any observers if successful.
  #
  # @return [true] if the blog instance saves.
  # @return [false] if the blog instance is not saved.
  def call
    @blog.attributes = @params

    return false unless @blog.save

    @blog.modified
    @blog.publish
    true
  end

end
