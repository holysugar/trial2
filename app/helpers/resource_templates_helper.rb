module ResourceTemplatesHelper
  def resource_form(resource, options = {}, &block)
    attrs = calculate_attrs(resource, options, :form)
    render 'resource_form', options.reverse_merge(:resource => resource, :attrs => attrs, :url => nil, :builder => nil)
  end

  def resources_index(resources, options = {}, &block)
    resource = resources.try(:first)
    if resources.present?
      attrs = calculate_attrs(resource, options, :index)
      render 'resources_index', options.reverse_merge(
        :resources => resources, :resource_class => resource.class,
        :attrs => attrs
      )
    else
      content_tag(:p, t(:'view.display_nothing'))
    end
  end

  def resource_show(resource, options = {}, &block)
    attrs = calculate_attrs(resource, options, :show)
    resource_class = resource.class
    render 'autocrud_show', options.reverse_merge(
      :resource => resource, :resource_class => resource.class,
      :attrs => attrs
    )
  end


  private
  def calculate_attrs(resource, options, default_autocrud)
    attrs = options[:attrs]
    if !attrs && resource.respond_to?(:autocrud_attrs_for)
      attrs = resource.autocrud_attrs_for(options[:autocrud] || default_autocrud)
    end
    attrs || resource.attribute_names.map(&:to_sym)
  end
end

ApplicationHelper.send(:include, ResourceTemplatesHelper)

