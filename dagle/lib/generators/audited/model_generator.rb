module Audited
  module Generators
    class ModelGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)
      def add_audited
        return if @behavior == :revoke
        inject_into_class File.join('app/models', class_path, "#{file_name}.rb"), class_name do
          "  audited\n"
        end
      end
    end
  end
end
