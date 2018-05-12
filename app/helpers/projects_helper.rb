# View model class for projects.
module ProjectsHelper
  def projects_breadcrumbs(current_view)
    [link_to(t('home'), root_path, class: 'breadcrumb-item')].tap do |arr|
      case current_view
      when /index/
        arr << add_content(t('projects'))
      when /show/
        arr << link_to(t('projects'), projects_path, class: 'breadcrumb-item')
        arr << add_content(@project.title)
      end
    end
  end

  private

  def add_content(title)
    content_tag(:span, title, class: 'breadcrumb-item active')
  end
end
