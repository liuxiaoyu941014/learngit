# == Usage
# in config/application.rb
# generators do |app|
#   require 'rails/generators/base'
#   require 'generators/base_concern'
#   Rails::Generators::Base.send :include, Generators::BaseConcern
# end
module Generators
  module BaseConcern
    def model_class_name(name: class_name, origin: class_name)
      klass = name.constantize rescue Object
      return name if klass < ActiveRecord::Base
      folders = name.split('::')
      folders.shift
      return origin if folders.size == 0
      model_class_name(name: folders.join('::'), origin: origin)
    end

    def model_var_name
      model_class_name.underscore.gsub('/', '_')
    end

    def plural_model_var_name
      model_var_name.pluralize
    end
  end
end
