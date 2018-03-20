module Decorator
  module Helpers
    def decorate(object, klass = nil)
      klass ||= "#{object.class.name}Decorator".constantize
      v = klass.new(object)
      yield v if block_given?
      v
    end
  end
end
