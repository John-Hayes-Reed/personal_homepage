# Controller for Home pages.
class HomeController < ApplicationController
  def index
    initialize_markdown_renderer
    @introduction = <<~INTRO_CODE
      ```ruby
        Human.new(
          name: 'John Stephen Hayes-Reed'
        )
      ```
    INTRO_CODE
  end

  private

  def initialize_markdown_renderer
    @markdown = Redcarpet::Markdown.new Redcarpet::Render::HTML,
                                        autolink: true,
                                        fenced_code_blocks: true
  end
end
