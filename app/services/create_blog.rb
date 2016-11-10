class CreateBlog < BottledService
  # include ActionDispatch::Flash
  delegate :t, to: 'I18n'

  att :title, String
  att :body, String


  def call
    @blog = Blog.create(title: @title, body: @body)
    if @blog.errors.present?
      # flash[:alert] = @blog.errors.full_messages
    else
      # flash[:notice] = t('successfully_created')
    end
    @blog
  end

end
