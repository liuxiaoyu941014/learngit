module Rspec
  module Generators
    class DecoratorGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)

      def copy_files # :nodoc:
        template 'model_rspec.rb', File.join('spec/decorators/', class_path, "#{file_name}_spec.rb").to_s
      end
    end
  end
end
