# encoding: utf-8

module ProjectsHelper
  def project_simple_info(project)
    content_tag(:em) do
      html = link_to project.creator.name, project.creator
      html << "创建于#{time_ago_in_words(project.created_at)}前"
    end
  end

  def search_form
    form_tag(projects_path, method: :get) do
      content_tag(:div, class: "input-append center") do
        html = search_field_tag(:search, nil, class: "span8")
        html << submit_tag('Go', class: 'btn')
      end
    end
  end
end
