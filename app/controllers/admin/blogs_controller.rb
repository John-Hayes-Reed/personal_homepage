# @abstract The admin namespace controller for handling Blogs.
# app/controllers/admin/blogs_controller.rb
class Admin::BlogsController < ApplicationController
  before_action :authenticate_admin!

  # GET /admin/blogs
  def index
    find_blogs
  end

  # GET /admin/blogs/1
  def show
    find_blog
    initialize_markdown_renderer
  end

  # GET /admin/blogs/new
  def new
    build_blog
  end

  # POST /admin/blogs
  def create
    build_blog
    if persist_blog
      redirect_to admin_blog_path @blog
    else
      render :new
    end
  end

  # GET /admin/blogs/edit/1
  def edit
    find_blog
  end

  # PUT   /admin/blogs/1
  # PATCH /admin/blogs/1
  def update
    find_blog
    if persist_blog
      redirect_to admin_blog_path @blog
    else
      render :edit
    end
  end

  # DELETE /admin/blogs/1
  def destroy
    find_blog
    if @blog.destroy
      redirect_to admin_blogs_path
    else
      render :edit
    end
  end

  private

  # Build a new instance of the Blog model
  #
  # @return [Blog]
  def build_blog
    @blog = BuildBlog.call
  end

  # Finds a Blog record from the database and defines it with the @blog instance
  #   variable.
  #
  # @return [void]
  def find_blog
    @blog = InitializeBlog.call id: params[:id]
  end

  # Creates a list of Blog records
  #
  # @return [void]
  def find_blogs
    @blogs = Blog.all
  end

  # Persists a Blog to the database with the parameters provided.
  #
  # @return [true] if the Blog successfully saves.
  # @return [false] if the Blog fails to save.
  def persist_blog
    PersistBlog.call blog: @blog, params: blog_params
  end

  def blog_params
    FilterBlogParams.call params: params
  end

  # Defines the markdown renderer with the @markdown instance variable
  #
  # @return [void]
  # @todo Move the below logic to a Service Object.
  def initialize_markdown_renderer
    @markdown = Redcarpet::Markdown.new Redcarpet::Render::HTML,
                                        autolink: true,
                                        fenced_code_blocks: true
  end
end
