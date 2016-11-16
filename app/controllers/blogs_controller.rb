class BlogsController < ApplicationController

  def index
    @blogs = Blog.all
  end

  def show
    find_blog
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, fenced_code_blocks: true)
  end

  private

  def find_blog
    @blog = Blog.find(params[:id])
  end
end
