module BlogsHelper

  def blogs_breadcrumbs(current_view)
    [].tap do |arr|
      arr << link_to(t('home'), root_path, class: 'breadcrumb-item')
      arr << content_tag(:span, t('blog'), class: 'breadcrumb-item active') if current_view.match /index/
      arr << link_to(t('blog'), blogs_path, class: 'breadcrumb-item') if current_view.match /show/
      arr << content_tag(:span, @blog.title, class: 'breadcrumb-item active') if current_view.match /show/
    end
  end
end
