# == Usage
# in config/application.rb
# generators do |app|
#   require 'rails/generators/rails/scaffold_controller/scaffold_controller_generator'
#   require 'generators/mudulize_template_concern'
#   Rails::Generators::ScaffoldControllerGenerator.send :include, Generators::ModulizeTemplateConcern
# end
module Generators
  module ModulizeTemplateConcern
    extend ActiveSupport::Concern

    included do
      class_option :module, type: :string, banner: 'admin, agent or member', desc: 'Default: the first part of path(admin/product, module is admin)'
    end

    # Support scaffold module template
    def find_in_source_paths(file)
      return super(file) if @behavior == :revoke
      return super(file) unless file == 'controller.rb'

      m_file = nil

      m = options[:module].presence
      if m
        m_file = "#{m}/controller.rb"
        return super(m_file)
      end

      folders = name.split('/')
      folders.pop

      loop do
        break if folders.size == 0
        m = folders.join('/')
        begin
          m_file = "#{m}/controller.rb"
          say "choosing #{m_file}", :yellow
          return super(m_file)
        rescue Thor::Error => e
          say "#{m_file} not found", :yellow
          folders.pop if e.message =~ /^Could not find /
        end
      end

      super(file)
    end

  end
end
