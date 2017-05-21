class BlogsController < ApplicationController

  def index
    find_blogs
  end

  def show
    find_blog
    initialize_markdown_renderer
  end

  private

  def find_blogs
    @blogs = Blog.all
  end

  def find_blog
    @blog = InitializeBlog.call id: params[:id]
  end

  def initialize_markdown_renderer
    @markdown = Redcarpet::Markdown.new Redcarpet::Render::HTML,
                                        autolink: true,
                                        fenced_code_blocks: true
  end
end
