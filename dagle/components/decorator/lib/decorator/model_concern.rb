module Decorator
  module ModelConcern
    extend ActiveSupport::Concern

    included do
      scope :decorate, ->{ all.map{ |r| "#{name}Decorator".constantize.new(r) } }
    end
  end
end
