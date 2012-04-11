module ResourceTemplatesHelper
  def resource_form(resource, options = {}, &block)
    render 'resource_form', options.reverse_merge(:resource => resource, :url => nil, :builder => nil)
  end

  def resources_index(resources, options = {}, &block)
    if resources.present?
      resource_class = resources.first.class
      render 'resources_index', options.reverse_merge(
        :resources => resources, :resource_class => resources.first.class)
    else
      content_tag(:p, t(:'view.display_nothing'))
    end
  end
end

ApplicationHelper.send(:include, ResourceTemplatesHelper)

