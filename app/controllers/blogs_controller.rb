class BlogsController < ApplicationController

  def index
    @blogs = Blog.all
  end

  def show
    find_blog
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, fenced_code_blocks: true)
  rescue ActiveRecord::RecordNotFound => e
    redirect_to blogs_path, alert: t('blog_not_found')
  end

  private

  def find_blog
    @blog = Blog.find(params[:id])
  end
end
