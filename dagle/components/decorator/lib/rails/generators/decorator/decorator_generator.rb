module Rails
  module Generators
    class DecoratorGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)

      def copy_decorator_files
        template 'model_decorator.rb', File.join('app/decorators/', class_path, "#{file_name}_decorator.rb").to_s
      end

      hook_for :test_framework, as: :decorator
    end
  end
end
