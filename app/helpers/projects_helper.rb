module ProjectsHelper

  def projects_breadcrumbs(current_view)
    [].tap do |arr|
      arr << link_to(t('home'), root_path, class: 'breadcrumb-item')
      arr << content_tag(:span, t('projects'), class: 'breadcrumb-item active') if current_view.match /index/
      arr << link_to(t('projects'), projects_path, class: 'breadcrumb-item') if current_view.match /show/
      arr << content_tag(:span, @project.title, class: 'breadcrumb-item active') if current_view.match /show/
    end
  end

end
