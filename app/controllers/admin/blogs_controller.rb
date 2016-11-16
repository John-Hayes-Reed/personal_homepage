class Admin::BlogsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @blogs = Blog.all
  end

  def show
    @blog = Blog.find(params[:id])
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, fenced_code_blocks: true)
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = CreateBlog.(title: blog_params[:title], body: blog_params[:body])
    render :new and return if @blog.errors.present?
    redirect_to admin_blog_path @blog
  end

  def edit
    find_blog
  end

  def update
    UpdateBlog.(title: blog_params[:title], body: blog_params[:body], blog: find_blog)
    render :edit and return if @blog.errors.present?
    redirect_to admin_blog_path @blog
  end

  def destroy
    find_blog.destroy
    redirect_to admin_blogs_path
  end

  private

  def find_blog
    @blog = Blog.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:title, :body)
  end
end
