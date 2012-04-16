# FIXME : spec
module AutocrudAttrs
  extend ActiveSupport::Concern

  included do
    autocrud_attrs = {}

    define_method(:autocrud_attrs) do
      autocrud_attrs
    end

    define_singleton_method(:autocrud_attrs_for) do |key, attrs=[]|
      attrs = Array.wrap(attrs) unless attrs.is_a?(Proc)
      autocrud_attrs[key] = attrs
    end
  end

  module ClassMethods
    def default_autocrud_attrs
      if respond_to?(:attribute_names)
        attribute_names.reject{|s| /(?:_|\A)(?:id|on|at)\z/ =~ s }.map(&:to_sym)
      else
        []
      end
    end
  end
  include ClassMethods

  def autocrud_attrs_for(key)
    if autocrud_attrs.key?(key)
      attrs = autocrud_attrs[key]
      #attrs = attrs.call if attrs.respond_to?(:call)
      attrs = instance_eval(&attrs) if attrs.is_a?(Proc)
      attrs
    else
      case key
      when :form, :index, :show
        default_autocrud_attrs
      else
        logger.info "Undefined autocrud attr"
        []
      end
    end
  end
end

