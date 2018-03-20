module Cud
  module Generators
    class ModelGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)

      def copy_files
        template 'create.rb', File.join('app/models/', class_path, file_name, 'create.rb').to_s
        template 'update.rb', File.join('app/models/', class_path, file_name, 'update.rb').to_s
        template 'destroy.rb', File.join('app/models/', class_path, file_name, 'destroy.rb').to_s
      end

      hook_for :test_framework, as: :cud
    end
  end
end
