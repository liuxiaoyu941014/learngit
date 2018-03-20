module Decorator
  class Railtie < ::Rails::Railtie

    initializer 'decorator' do
      ActiveSupport.on_load(:action_controller) do
        ActionController::Base.helper Decorator::Helpers
      end
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.send(:include, Decorator::ModelConcern)
      end
    end

    generators do |app|
      require 'rails/generators/rails/model/model_generator'
      require 'rails/generators/decorator/decorator_generator'
      Rails::Generators::ModelGenerator.hook_for :decorator, default: true
    end
  end
end
