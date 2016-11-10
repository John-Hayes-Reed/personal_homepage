class UpdateBlog < BottledService
  # include ActionDispatch::Flash
  delegate :t, to: 'I18n'

  att :blog, Blog
  att :title, String
  att :body, String


  def call
    @blog.update(title: @title, body: @body)
    if @blog.errors.present?
      # flash[:alert] = @blog.errors.full_messages
    else
      # flash[:notice] = t('successfully_updated')
    end
    @blog
  end

end
