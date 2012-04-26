require 'rails/generators/rails/scaffold/scaffold_generator'

module Trial
  module Generators
    class ScaffoldGenerator < Rails::Generators::ScaffoldGenerator
      source_root File.expand_path("../templates", __FILE__)
      argument :attributes, :type => :array, :default => [], :banner => "field[:type][:index] field[:type][:index]"

      def generate_decorator
        Rails::Generators.invoke 'decorator', [singular_name]
        inject_into_file "app/decorators/#{singular_name}_decorator.rb", <<-EOD, :after => "module #{class_name}Decorator\n"
  include AutocrudAttrs
  #autocrud_attrs_for :index, [#{attributes.map{|a| ":#{a.name}" }.join(', ')}]
        EOD
      end

      def controller_with_kaminari
        if Kernel.const_defined?("Kaminari")
          gsub_file("app/controllers/#{table_name}_controller.rb", "@#{table_name} = #{class_name}.all") do |match|
            match.sub('.all', '.page params[:page]')
          end
        end
      end

      def fix_spec_with_responder_controller
        gsub_file "spec/controllers/#{table_name}_controller_spec.rb", "#{class_name}.any_instance.stub(:save).and_return(false)", \
          "#{class_name}.any_instance.stub(:errors){ ActiveModel::Errors.new(#{class_name}.new).tap{|e| e.add(:id, 'something wrong')} }"
      end

      def print_notification
        say "Please check below:"
        say " * Add validation to app/models/#{singular_name}.rb"
        say " * Add valid model parameter to spec/controllers/#{table_name}_controller_spec.rb"
        say " * Migrate DB (adding constraints if needed)"
      end

      undef generate_view_specs

    end
  end
end
