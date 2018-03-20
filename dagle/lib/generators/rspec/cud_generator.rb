module Rspec
  module Generators
    class CudGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('../templates/cud', __FILE__)

      def copy_files # :nodoc:
        template 'create_spec.rb', File.join('spec/models', class_path, file_name, 'create_spec.rb').to_s
        template 'update_spec.rb', File.join('spec/models', class_path, file_name, 'update_spec.rb').to_s
        template 'destroy_spec.rb', File.join('spec/models', class_path, file_name, 'destroy_spec.rb').to_s
      end
    end
  end
end
