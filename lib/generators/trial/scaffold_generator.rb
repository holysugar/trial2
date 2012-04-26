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
          gsub_file("app/controllers/#{table_name}_controller.rb", /(@#{singular_name} = #{class_name})\.all/) do |match|
            match + '.page params[:page]'
          end
        end
      end

      def fix_spec_with_responder_controller
        gsub_file "spec/controllers/#{table_name}_controller_spec.rb", "#{class_name}.any_instance.stub(:save).and_return(false)" do |match|
          "#" + match
        end
      end

    end
  end
end
