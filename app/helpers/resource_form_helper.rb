module ResourceFormHelper
  def resource_form(resource, options = {}, &block)
    render 'semantic_form', options.reverse_merge(:resource => resource, :url => nil, :builder => nil)
  end
end

ApplicationHelper.send(:include, ResourceFormHelper)

