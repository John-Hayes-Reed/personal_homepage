# View model for blogs pages.
module BlogsHelper
  def blogs_breadcrumbs(current_view)
    [link_to(t('home'), root_path, class: 'breadcrumb-item')].tap do |arr|
      case current_view
      when /index/
        arr << add_content(t('blog'))
      when /show/
        arr << link_to(t('blog'), blogs_path, class: 'breadcrumb-item')
        arr << add_content(@blog.title)
      end
    end
  end

  private

  def add_content(title)
    content_tag(:span, title, class: 'breadcrumb-item active')
  end
end
