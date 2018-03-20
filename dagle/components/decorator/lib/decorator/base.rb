module Decorator
  class Base < SimpleDelegator
    include ActiveModel::Serializers::JSON
    # 解决I18n的解析问题
    def self.model_class
      self.name.gsub(/Decorator$/, '').constantize
    end

    def self.model_name
      model_class.model_name
    end

    def self.human_attribute_name(*args)
      model_class.human_attribute_name(*args)
    end

    def object
      __getobj__
    end

    def h
      ActionController::Base.helpers
    end

    def r
      Rails.application.routes.url_helpers
    end
  end
end
